## Rechten uitdelen in Power BI

We moeten nu in Power BI nog toestaan dat de Service Principal beheer-taken mag uitvoeren. Doe hiervoor de volgende stappen:

44. Ga naar de [Tenant Settings in de Admin Portal van Power BI](https://app.powerbi.com/admin-portal/tenantSettings)
44. Scroll naar het kopje **Developer settings** (bijna onderaan), en klik **Allow service principals to use Power BI APIs** open.
44. Zet deze op **Enabled** en stel deze in voor **Specific security groups (recommended)**
44. Zoek de zojuist aangemaakte AD-groep *Azure DevOps Deployment Agent voor PowerBI* op
44. Kies **Apply**

![Maak het mogelijk om de Power BI tenant een deployment te laten uitvoeren](img/43-powerbi-tenant-settings-use-powerbi-apis.png)

