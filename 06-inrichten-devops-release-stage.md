# Inrichten van de Stage

Om de uitrol van je Power BI rapport daadwerkelijk te automatiseren, moet er een stappenplan komen: de *tasks* list. We gaan hiervoor taken toevoegen.

## Voorbereiding

We hebben zojuist een [nieuwe release pipeline ingericht in Azure DevOps Pipelines](05-inrichten-azure-devops-release-pipeline.md). We hebben hier al een *artifact* aan gekoppeld, zodat de rapporten die we in versiebeheer zetten ook meekomen in een deployment. Nu zijn we de eerste *stage* aan het inrichten binnen de release pipeline.

## Taken toevoegen

9. Klik op het plusje naast de tekst **Agent Job**

![Plusje naast agent job](img/32-plusje-naast-agent-job.png)

10. Zoek naar **Power BI**

Er zijn nu twee mogelijke uitkomsten:

a. Er staat bovenaan een tekst **Marketplace**, met daaronder diverse mogelijke taken  
b. Er staan bovenaan één of meer taken, gevolgd door de tekst Marketplace

**Wanneer er boven *Marketplace* géén taken staan, moeten we eerst een taak toevoegen.** De taak wordt dan goedgekeurd voor je gehele *organization*, en kan daarna overal gebruikt worden.

### Toevoegen van de Power BI Actions taak aan je DevOps organization

Wanneer je voor het eerst een Power BI rapport wilt uitrollen via Azure DevOps, staan er nog geen Power BI-componenten in de takenlijst van Azure DevOps. Je moet nu éénmalig de taak **Power BI Actions** toevoegen aan je *organization* (daarna kun je de stappen 11-16 dus overslaan)

11. Klik op de taak **Power BI Actions** onder het kopje **Marketplace**
11. Kies **Get it free**

![Get it free](img/29-get-it-free.png)

Er opent zich een nieuw tabblad, met de **Visual Studio Marketplace**

13. Klik op **Get it free**

![Get it free 2](img/28-get-it-free-2.png)

14. Kies de DevOps organization waarbinnen je de Power BI bestanden en pipelines hebt neergezet.

![Kies DevOps organization](img/30-kies-devops-org.png)

15. Klik **Proceed to organization**

![Proceed to organization](img/31-proceed-to-organization.png)

Power BI Actions is nu beschikbaar als taak binnen Azure DevOps pipelines. 

16. Schakel terug naar het browsertabblad waar je de DevOps pipeline aan het bewerken was, en klik **Refresh** naast **Add tasks**. 

![Refresh tasks](img/33-refresh-tasks.png)

17. Klik de zojuist toegevoegde **Power BI Actions** release task, en kies **Add**

![Power BI Actions release task](img/34-powerbi-actions-release-task.png)

18. Klik nu de zojuist toegevoegde **task** aan. Alle instellingen die erbij horen komen nu aan de rechterzijde.

Voordat we vanuit **Azure DevOps** een rapport kunnen releasen binnen **Power BI**, moeten we eerst een **service-connection** aanmaken. 
We gaan hier een **Service Principal** voor gebruiken.
Dit is iets wat je normaal gesproken maar één keer hoeft in te richten.

19. Klik onder **Power BI service connection** op **New**

![New service principal - connection](img/35-new-service-principal-connection.png)

### Inrichten van een service principal in de Azure Portal

Voordat Azure DevOps de eerste keer taken kan uitvoeren binnen Power BI, moet er eerst een account zijn waarmee Power BI dit kan doen. Deze inrichting doen we allereerst in de Azure Portal.

20. Open in een nieuw tabblad de [Azure portal](https://portal.azure.com)
21. Navigeer naar [Azure Active Directory](https://portal.azure.com/#blade/M1crosoft_AAD_IAM/ActiveDirectoryMenuBlade/Overview)
21. Ga naar **App registrations**
21. Klik op **New Registration**

![New app registration](img/36-new-app-registration.png)

24. Geef deze de naam **Azure DevOps deployments voor Power BI**. Laat de overige instellingen staan, en kies **Register**

![Register application - settings](img/37-register-application-settings.png)

We hebben nu een **registratie** binnen Azure AD gemaakt, maar deze heeft nog geen **rechten**. Ook is er nog geen manier om te **authenticeren**.

Rechten

26. Klik op **API permissions** om rechten toe te kennen.
26. Kies **Add a permission**
26. Kies voor **Power BI Service**

![Add API Permisions](img/38-api-permissions.png)

Azure AD vraagt nu wat voor soort *permissions* er nodig zijn.

29. Kies voor **Application permissions**
29. Selecteer alle permissies binnen **Power BI Service**. Kies **Add permissions**

![Request API permissions](img/39-request-api-permissions.png)

31. **Belangrijk: Kies nu voor *Grant admin consent for (jouw organisatie)***. Dit zorgt ervoor dat de permissies die de applicatie *nodig heeft* ook daadwerkelijk *gegeven worden*.

![Grant admin consent](img/40-grant-admin-consent.png)

32. Ga naar **Certificates & Secrets**
32. Klik **New client secret**
32. Geef deze nieuwe secret de naam **Azure DevOps voor Power BI secret**, en selecteer onder **Expires** een waarde ver in de toekomst.

![Create Secret](img/43-create-secret-firststep.png)

35. Kopieer de waarde van de secret die nu in je scherm komt, en plak deze tijdelijk op een plek waar je de secret later kunt terugvinden

Naast de *secret* die je zojuist gekopieerd hebt, hebben we nog twee andere gegevens nodig van de zojuist aangemaakte *service principal*.

36. Ga naar **overview**
37. Kopieer de volgende waarden naar een plek waar je ze straks eenvoudig terug kunt vinden:
    * **Application (client) ID**
    * **Directory (tenant) ID**

We hebben nu een service account aangemaakt. Vanuit Azure mag dit account weliswaar in Power BI enkele zaken uitvoeren, maar Power BI zelf staat nog niet toe dat service accounts de API gebruiken.

Security-wise is dat een goede keuze: we willen niet dat elk account met "toevallig" rechten op Power BI ook de API kan gebruiken. In plaats daarvan maken we een *security group* aan binne Azure AD. Binnen de Power BI admin zullen we vervolgens hier de benodigde rechten aan geven.

38. Navigeer terug naar de *Azure Active Directory* en kies voor **Groups**.
38. Kies **New Group**

![Create new security group](img/41-aad-groups.gif)

40. Geef deze groep de naam **Azure DevOps Deployment Agent voor Power BI**
40. Voeg als **member** de zojuist aangemaakte **App** toe
40. Klik **Select**
40. Klik **Create** om de groep aan te maken

![New security group settings](img/42-add-members-to-group.png)

We hebben in de Azure Portal nu alle instellingen gedaan die nodig zijn voor de *service principal*. We gaan nu de drie gekopieerde waarden invullen in de nieuwe *Service Connection*

44. Open het tabblad waarin je de pipeline momenteel bewerkt. 

Als het goed is, staat het *pane* nog open waarin je de nieuwe **service connection** naar Power BI aan het leggen was. 

45. Vul de volgende gegevens in:
    * Authentication method: **Service Principal**
    * Organization type: **Commercial (Public)**
    * **Tenant ID**: De eerder gekopieerde **Directory (tenant) ID**
    * **Client ID**: De eerder gekopieerde **Application (client) ID**
    * **Client Secret**: De eerder gekopieerde **Client secret**
    * **Service connection name**: Power BI voor Azure DevOps
    * Vink het vakje **Grant access permission to all pipelines** aan
    * Klik **Save**

![New service connection settings](img/44-new-devops-service-connection-settings.png)

> Er zijn twee mogelijkheden om te authenticeren bij Power BI: **User** en **Service Principal**.
> 
> Een **User** account is een *regulier* Power BI-account, waar géén Multi-Factor Authentication op geactiveerd is. Daarnaast moet je in de Power BI Developer-portal een app registreren.
> Een **service principal** is een specifiek account voor automatisering binnen Azure. Deze zijn specifiek voor geautomatiseerde processen bedoeld. Daarom kiezen we nu voor een **service principal**.

46. Vul bij **Workspace Name** een nieuwe workspace in die we gaan gebruiken voor deze deployment: `demo-pbug-2023`
46. Gebruik de knop met ellipsis (`...`) om het Power BI rapport te selecteren in Azure Repos Git
46. Vink de volgende opties aan:
    * **Overwrite Power BI File**
    * **Create if the workspace does not exist**
49. Hernoem de pipeline naar *Voorbeeld deployment* en klik op **Save**

![Hernoem pipeline en sla op](img/46-opslaan-pipeline.png)

## Voordat je de release uitvoert

Voordat je nu een release uitvoert, is het verstandig om de zojuist benoemde Power BI workspace (`demo-pbug-2023`) handmatig aan te maken.

Wanneer je dit niet doet, zal Power BI Actions voor jou de workspace aanmaken, maar heb je hier nog niet automatisch rechten op. Je kunt er dan niet zomaar bij.

Na het aanmaken van de workspace moet je de service principal administrator-rechten geven op deze specifieke workspace. Dit zorgt ervoor dat hier deployments op kunnen plaatsvinden.

![Add admin to workspace](img/50-add-admin-to-workspace.png)