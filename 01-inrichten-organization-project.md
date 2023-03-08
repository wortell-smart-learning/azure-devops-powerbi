# Setup Guide Azure Devops voor Power BI

## Introductie

In deze **Setup Guide** staat stap-voor-stap hoe je je eerste Azure DevOps-omgeving kunt inrichten. **Wanneer je al een *organization* en *project* hebt binnen Azure DevOps kun je deze setup guide overslaan**.

## Stappenplan

Het stappenplan ziet er globaal als volgt uit:

1. Opzetten Azure DevOps organization
2. Inrichten Azure DevOps project

## Stappenplan in detail

Hieronder wordt in detail door de diverse stappen heen gelopen

### Opzetten Azure DevOps organization

* Ga naar [dev.azure.com](https://dev.azure.com/)
* Log in met een account dat gebruikt kan worden voor de training.
  * Wanneer dit toegestaan is, mag je een account vanuit je organisatie gebruiken.
  * Je kunt ook een bestaand Microsoft- of GitHub-account gebruiken, of hier een account voor aanmaken.

| Als trainingsaanbieder kun je hier inloggen met een account in het domein waar (tijdelijke) cursisten-accounts ook mogen bestaan.

Wanneer je voor het eerst inlogt op Azure DevOps, krijg het je het "get started with Azure DevOps" scherm:

![Scherm met extra gegevens bij eerste login](img/01-first-use.png)

Wanneer je eerder al van Azure DevOps gebruik gemaakt hebt, zul je dit scherm niet tegenkomen, maar kun je direct een nieuwe *Organization* aanmaken.

Maak nu een nieuwe *Organization* aan, door onderin het lijstje met bestaande *organizations* te kiezen voor **New Organization**.

![Link "New Organization"](img/02-new-organization.png)

Je krijgt nu het scherm **Get started with Azure DevOps**. Klik op **continue**.

![Get started with Azure DevOps](img/03-get-started-with-azure-devops.png)

Geef je *organization* een naam, en vul indien nodig de captcha correct in.

![Name your Azure DevOps organization](img/04-name-devops-org.png)

### Aanvragen van een "free tier"

Je wilt Azure DevOps gaan gebruiken voor de deployment van Power BI-rapporten. Het uitvoeren van die deployment vereist echter dat er ergens op de wereld een computer moet draaien die dat voor je uitvoert.

Microsoft heeft een zogenaamde "free tier" hier ingebouwd: je kunt per organisatie 1800 minuten aan DevOps Pipelines per maand gratis krijgen. **Wanneer je de "free tier" niet hebt, moet je zelf een server opzetten of huren - anders kun je geen deployment pipelines inzetten.**

Aanvragen kan via het formulier [https://forms.office.com/pages/responsepage.aspx?id=v4j5cvGGr0GRqy180BHbR63mUWPlq7NEsFZhkyH8jChUMlM3QzdDMFZOMkVBWU5BWFM3SDI2QlRBSC4u](https://forms.office.com/pages/responsepage.aspx?id=v4j5cvGGr0GRqy180BHbR63mUWPlq7NEsFZhkyH8jChUMlM3QzdDMFZOMkVBWU5BWFM3SDI2QlRBSC4u)

Belangrijk:

* **Lees het formulier goed door** (zodat je niet per ongeluk een URL invoert inplaats van de naam van je organisation)
* Het gaat om **private** projecten

Na het indienen van dit formulier krijg je binnen enkele werkdagen een e-mail.

Dit gaat alleen over het stukje van de **DevOps Pipelines**. De rest van dit stappenplan kun je dus gewoon volgen, en ook DevOps Repos kun je al gewoon gebruiken.

### Inrichten Azure DevOps project

Met de nieuwe *organization* geopend in de linkerzijde van het scherm, zie je aan de rechterzijde het volgende scherm:

![Create a project to get started](img/05-create-project-to-get-started.png)

Geef het project een naam, en klik op **Create project**
