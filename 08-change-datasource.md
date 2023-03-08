# Veranderen van datasources gedurende deployment

Het is mogelijk om via de Power BI API de datasource van een rapport te veranderen. We volgen daarvoor het volgende stappenplan:

* Publiceer het rapport
* Verander de datasource (bijvoorbeeld naar de test-database)
* Ververs de data

## Uitbreiden van de pipeline

1. Open **Azure DevOps**, navigeer naar **Pipelines**, **Releases**.
1. Maak een **clone** van de **Voorbeeld pipeline** die we eerder gemaakt hebben. 

![Clone de voorbeeld-pipeline](img/47-clone-voorbeeld-pipeline.png)

De *clone* van de pipeline opent zich

3. Klik op de titel (*Voorbeeld pipeline - Copy*), en hernoem deze naar **Voorbeeld datasource wijziging**. 
3. Sla de pipeline op
3. Open de **tasks** voor de **Test** stage
3. Voeg opnieuw een **Power BI Action** taak aan toe, en geef deze de volgende instellingen mee:
   * Power BI Service connection: selecteer uit de dropdown **Power BI voor Azure DevOps**
   * Action: **Update DataSource connection**
   * Workspace Name: `demo-pbug-2023`
   * Vink **Update all datasources in workspace** aan
   * Dataset name: *laat leeg*
   * Datasource: **SQL**
   * Old server: **wortellsmartlearning.database.windows.net**
   * New server: **wortellsmartlearning-test.database.windows.net**
   * Old database: **courses**
   * New database: **courses-test**
3. Sla de pipeline op
3. Maak een nieuwe release aan.

## Conclusie - waar staan we?

We hebben nu een geautomatiseerde deployment van Power BI. Na de deployment wordt de datasource "omgehangen". Echter, Power BI kent (nog) geen *credentials* voor het rapport dat zojuist gepubliceerd is.

Er zijn diverse tools in de Azure DevOps Marketplace die een stukje van dit probleem oplossen, maar er is momenteel helaas niet één tool binnen de Visual Studio Marketplace waarin het mogelijk is om alles te doen wat we nodig hebben:

* Rapporten te publiceren
* Data sources te veranderen (nodig voor de DTAP/OTAP-straat)
* Credentials te veranderen

Vroeg of laat loop je hier tegenaan, en zul je - al dan niet in samenwerking met iemand die wat meer PowerShell en/of REST API-ervaring heeft - zelf een script moeten maken.

Dat is dan ook wat we als laatste stap gaan doen.