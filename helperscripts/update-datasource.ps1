# Helper script to change not only a Database name and server, but also the *username* and *password* of a SQL source.

param (

# SOURCE report info
    [string]$sourceReportGroupName = "",    # the name of the app where datasets should be updated
    [string]$dbnameToReplace = "",
    [string]$dbservernameToReplace = "",
    [string]$dbname = "",
    [string]$dbserver = "",
    [string]$dbuser = "",
    [string]$dbpass = "",

	[guid]$appId = "", 
	[string]$tenantId = "", 
	[string]$clientSecret = "" 
) 

# End Parameters =======================================

$clientId = $appId
$resourceId = "https://analysis.windows.net/powerbi/api"
$login = "https://login.microsoftonline.com"
$secret = $clientSecret

$clientCredential = New-Object Microsoft.IdentityModel.Clients.ActiveDirectory.ClientCredential($clientId,$secret)
$authContext = New-Object Microsoft.IdentityModel.Clients.ActiveDirectory.AuthenticationContext("{0}/{1}" -f $login,$tenantId)
$authenticationResult = $authContext.AcquireTokenAsync($resourceId, $clientcredential).GetAwaiter().GetResult()
$token = $authenticationResult.AccessToken
#$authenticationResult = [Microsoft.IdentityModel.Clients.ActiveDirectory.AuthenticationContextIntegratedAuthExtensions]::AcquireTokenAsync($authContext, $resourceURL, $clientId, $clientCredential).Result;

#Write-Host "Token: $($token)"


# Building Rest API header with authorization token
Write-Host "Building API header"
$authHeader = @{
   'Content-Type'='application/json'
   'Authorization'= "Bearer $($token)"
}

# Get group ID
$uri = "https://api.powerbi.com/v1.0/myorg/groups"
Write-Host "Invoking request"
$response = Invoke-RestMethod -Uri $uri -Headers $authHeader -Method GET  -Verbose
Write-Host "Received response: $($response)"
foreach ($group in $response.value) {
	Write-Host "Evaluating value: $($group.name), compare to: $($sourceReportGroupName)"
	if($group.name -eq $sourceReportGroupName) {
		$sourceReportGroupId = $group.id
		Write-Host "Found id for resource group: $($sourceReportGroupId)"
	}
}

# properly format groups path
$sourceGroupsPath = ""
if ($sourceReportGroupId -eq "me") {
    $sourceGroupsPath = "myorg"
} else {
    $sourceGroupsPath = "myorg/groups/$($sourceReportGroupId)"
}

# Get list of datasets in source
$uri = "https://api.powerbi.com/v1.0/$($sourceGroupsPath)/datasets"
$response = Invoke-RestMethod -Uri $uri -Headers $authHeader -Method GET  -Verbose

$toUpdate = $response.value

foreach ($dataset in $toUpdate) {
    if ($dataset.name -eq "Report Usage Metrics Model" -or $dataset.name -eq "Dashboard Usage Metrics Model" -or $dataset.name -eq "Usage Metrics Report") {
        Write-Host "Skipping update for: $($dataset.name)"
    }
    else {
        Write-Host "Checking refresh state of dataset: $($dataset.name)"
        $uri = "https://api.powerbi.com/v1.0/$($sourceGroupsPath)/datasets/$($dataset.id)/refreshes?`$top=1"
        $refreshState = Invoke-RestMethod -Uri $uri -Headers $authHeader -Method GET -Verbose
        Write-Host "Status of dataset: $($dataset.name) is: $($refreshState.value.status)" 
        #if ($refreshState.value.status -eq "Completed" -or [string]::IsNullOrEmpty($refreshState.value.status)) {
            Write-Host "Taking ownership of dataset: $($dataset.name)"
            Try {
                # POST body 
                $uri = "https://api.powerbi.com/v1.0/$($sourceGroupsPath)/datasets/$($dataset.id)/Default.TakeOver"
                Invoke-RestMethod -Uri $uri -Headers $authHeader -Method POST -Verbose
                Write-Host "Ownership taken for: $($dataset.name)"
            }
            Catch {
                Write-Host "Cannot take ownership of: $($dataset.name)"
            }
            Write-Host "Start updating parameters for dataset: $($dataset.name) id: $($dataset.id)"
            Try {
                # POST body 
                $postParams = @{
                    updateDetails  = (@{
                        "name" = "dbname"
                        "newValue" = "$($dbname)"
                    },
                    @{
                        "name" = "dbserver"
                        "newValue" = "$($dbserver)"
                    })
                }
                $jsonPostBody = $postParams | ConvertTo-JSON
                $uri = "https://api.powerbi.com/v1.0/$($sourceGroupsPath)/datasets/$($dataset.id)/Default.UpdateParameters"
                Invoke-RestMethod -Uri $uri -Headers $authHeader -Method POST -Body $jsonPostBody -Verbose
                Write-Host "Parameters updated for: $($dataset.name)"
            }
            Catch {
                Write-Host "Dataset or Parameters not found in: $($dataset.name)"
            }

            Write-Host "Start updating details for dataset: $($dataset.name) id: $($dataset.id)"
            Write-Host $dataset.server
            Try {
                # POST body 
                $postParams = @{
                    updateDetails  = @(@{
                        "datasourceSelector" = @{
                            "datasourceType" = "Sql"
                            "connectionDetails" = @{
                                "server" =  "$($dbservernameToReplace)"
                                "database" = "$($dbnameToReplace)"
                            }
                        }
                        "connectionDetails" = @{
                            "server" = "$($dbserver)"
                            "database" = "$($dbname)"
                        }
                    })
                }
                $jsonPostBody = $postParams | ConvertTo-JSON -Depth 100
                Write-Host "Invoking $($uri)"
                Write-Host "Post body:"
                Write-Host $jsonPostBody
                $uri = "https://api.powerbi.com/v1.0/$($sourceGroupsPath)/datasets/$($dataset.id)/Default.UpdateDatasources"
                Invoke-RestMethod -Uri $uri -Headers $authHeader -Method POST -Body $jsonPostBody -Verbose
                Write-Host "Details updated for: $($dataset.name)"
            }
            Catch {
                Write-Host "Dataset or Parameters not found in: $($dataset.name)"
            }

            Write-Host "Get datasources of current dataset"
            $uri = "https://api.powerbi.com/v1.0/$($sourceGroupsPath)/datasets/$($dataset.id)/datasources"
            #$uri = "https://api.powerbi.com/v1.0/myorg/admin/datasets/$($dataset.id)/datasources"
            $response = Invoke-RestMethod -Uri $uri -Headers $authHeader -Method GET  -Verbose
            $datasourceId = $response.value.datasourceId
            $gatewayId = $response.value.gatewayId
            Write-Host "Start updating dataset: $($datasourceId) on gateway $($gatewayId)"

            Try {
                # POST body 
                $postParams = @{
                    credentialDetails = @{
                        credentialType = "Basic"
                        credentials = "{`"credentialData`":[{`"name`":`"username`", `"value`":`"$($dbuser)`"},{`"name`":`"password`", `"value`":`"$($dbpass)`"}]}"
                        encryptedConnection = "Encrypted"
                        encryptionAlgorithm = "None"
                        privacyLevel = "None"
                    }
                }
                $jsonPostBody = $postParams | ConvertTo-JSON
                $uri = "https://api.powerbi.com/v1.0/myorg/gateways/$($gatewayId)/datasources/$($datasourceId)"
                Write-Host "Invoking $($uri)"
                Write-Host "Post body:"
                Write-Host $jsonPostBody
                Invoke-RestMethod -Uri $uri -Headers $authHeader -Method PATCH -Body $jsonPostBody -Verbose
                Write-Host "Datasources updated for: $($dataset.name)"
            }
            Catch {
                Write-Warning "Datasource could not be updated for: $($dataset.name)"
            }
        #}
        #elseif ($refreshState.value.status -eq "Failed") {
        #    $Error_Message = [string]"Dataset failed updating: $($dataset.name)"
        #    Write-Error $Error_Message
        #}
    }
}
