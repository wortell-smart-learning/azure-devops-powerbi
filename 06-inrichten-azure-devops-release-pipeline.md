# Inrichten Azure DevOps Release pipeline

1. Ga naar Azure DevOps
2. Klik op Pipelines
3. Klik op Releases

> Wanneer je Azure DevOps-goeroes tegenkomt, zullen ze over het algemeen geen *release-pipelines* meer gebruiken. De reden hiervoor is dat Microsoft binnen Azure DevOps het onderscheid tussen "build" en "release" langzaamaan laat verdwijnen. In plaats daarvan komen "multi-stage pipelines".
>
> Voor ons doeleinde (het gestructureerd oplossen van je Power BI deployments met Azure DevOps), is dit echter de snelste manier om van start te gaan.

4. Klik "New Pipeline"
5. Klik **Empty job**

Azure DevOps vraagt je nu om de naam van je **Stage**. Een "stage" is voor ons het makkelijkst te vertalen als een "omgeving". Bijvoorbeeld een testomgeving, dus.

6. Geef je eerste stage de naam "Test" en sluit de *pane*

Je ziet nu een scherm met twee onderdelen:

* Artifacts
* Stages

*Artifacts* zijn datgene wat je uitrolt over de omgevingen. Het idee van een "artifact" is dat het *onveranderbaar* is: als ik iets op een testomgeving heb goedgekeurd, wil ik dat *exact hetzelfde rapport* ook op mijn productie-omgeving komt.

Onder *Stages* zie je de zojuist aangemaakte stage *Test*. Daaronder staat de tekst `1 job, 0 tasks`.

Bovenin je scherm zie je een aantal tabjes binnen je release-pipeline. Hier vind je allerhande instellingen.

We voegen nu eerst een artifact toe. Dit is het startpunt: om een rapport ergens te kunnen plaatsen (deployment) moeten we het ergens vandaan halen. Daarom koppelen we allereerst de artifact:

7. 



**TODO Eerst artifact toevoegen**

7. Klik nu op de tekst `1 job, 0 task`. Merk op dat je van **Pipeline** nu naar **Tasks** gaat.

Je komt nu in de taken die binnen jouw *stage* worden uitgevoerd. Azure DevOps verdeelt dit onder in **jobs** en **tasks**.
Een **job** is een verzameling taken die op een bepaald type computer moet worden uitgevoerd. Voor de uitrol van Power BI rapportages gebruik je gewoonlijk maar één job. Deze is standaard al voor je aangemaakt.

De **tasks** zijn datgene wat moet gebeuren om jouw *release* voor elkaar te krijgen.

8. Klik op **Agent job**. Je ziet aan de rechterzijde nu een eigenschappen-venster tevoorschijn komen. Als het goed is, staan de volgende instellingen hier:

* Agent Pool: Azure Pipelines
* Agent Specification: iets met Windows (vermoedelijk vs2017-win2016)

We gaan nu taken toevoegen.

9. Klik op het plusje naast de tekst **Agent Job**:
10. Zoek naar Power BI, en kies voor de taak **Power BI Actions** bovenaan de lijst
    * De taken onder **Marketplace** moeten eerst geïnstalleerd worden
    * Klik **Add**
11. Klik nu de zojuist toegevoegde **task** aan. Alle instellingen die erbij horen komen nu aan de rechterzijde.

Voordat we vanuit **Azure DevOps** een rapport kunnen releasen binnen **Power BI**, moeten we eerst een **service-connection** aanmaken. 
We gaan hier een **Service Principal** voor gebruiken.
Dit is iets wat je normaal gesproken maar één keer hoeft in te richten.

12. Kies onder **Authentication type** voor **Service Principal**
13. Klik onder **Power BI service connection** op **New**

> Er zijn twee mogelijkheden hier om te gebruiken: **User** en **Service Principal**.
> 
> Een **User** account is een *regulier* Power BI-account, waar géén Multi-Factor Authentication op geactiveerd is. Daarnaast moet je in het Power BI Developer-portaal een app registreren.
> Een **service principal** is een specifiek account voor automatisering binnen Azure. Deze zijn specifiek voor geautomatiseerde processen bedoeld. Daarom kiezen we nu voor een **service principal**.

14. Open in een nieuw tabblad de [Azure portal](https://portal.azure.com)
15. Navigeer naar [Azure Active Directory](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/Overview)
16. Ga naar **App registrations**
17. Klik op **New Registration**
18. Geef deze de naam **Azure DevOps deployments voor Power BI**. Laat de overige instellingen staan, en kies **Register**

We hebben nu een **registratie** binnen Azure AD gemaakt, maar deze heeft nog geen **rechten**. Ook is er nog geen manier om te **authenticeren**.

Rechten

19. Klik op **API permissions** om rechten toe te kennen.
20. Kies **Add a permission**
21. Kies voor **Power BI Service**

Azure AD vraagt nu wat voor soort *permissions* er nodig zijn.

22. Kies voor **Application permissions**
23. Selecteer alle permissies binnen **Power BI Service**. Kies **Add permissions**
24. **Belangrijk: Kies nu voor *Grant admin consent for (jouw organisatie)***. Dit zorgt ervoor dat de permissies die de applicatie *nodig heeft* ook daadwerkelijk *gegeven worden*.


**Todo: kopiëren/plakken van app ID en tenant ID**

Application (client) ID: da1bd6e4-0194-472c-8795-48adb23ae325
Directory (tenant) ID: bbc18099-da6e-445c-9d69-7592ab8e4fea
Object ID: 27856495-2114-4b61-baa3-84488e0f3d69

enterprise app:
Application ID: da1bd6e4-0194-472c-8795-48adb23ae325
Object ID: c9c273bf-ccd8-428a-ae72-d6cee8e3eb41

Om nu namens deze applicatie te kunnen werken, moeten we nog een *secret* aanmaken. 

25. Ga naar **Certificates & Secrets**
26. Klik **New client secret**
27. Geef deze nieuwe secret de naam **Azure DevOps voor Power BI secret**, en selecteer onder **Expires** de waarde **Never**

28. Kopieer de waarde van de secret die nu in je scherm komt, en plak deze op een plek waar je 'm later kunt terugvinden (bijv. Notepad)

4.oB4BE9192WI-FLoPD1Yw7N~4lQlt-8GB

29. Ga terug naar Overview

We moeten nu in Power BI nog toestaan dat de Service Principal beheer-taken mag uitvoeren. Doe hiervoor de volgende stappen:

30. Ga naar de [Tenant Settings in de Admin Portal van Power BI](https://app.powerbi.com/admin-portal/tenantSettings)
31. Scroll naar het kopje **Developer settings** (bijna onderaan), en klik **Allow service principals to use Power BI APIs** open.
32. Zet deze op **Enabled** en stel deze in voor **The entire organization**

**Todo: security groups stap tussenvoegen**

**Todo: Service Principal aan workspace toevoegen**
