# Changing data sources during deployment

It is possible to change the data source of a report via the Power BI API. We follow the following steps for this:

* Publish the report
* Change the data source (for example to the test database)
* Refresh the data

## Expanding the pipeline

1. Open **Azure DevOps**, navigate to **Pipelines**, **Releases**.
1. Create a **clone** of the **Sample Pipeline** we created earlier.

![Clone the example pipeline](img/47-clone-voorbeeld-pipeline.png)

The *clone* of the pipeline opens

3. Click on the title (*Example pipeline - Copy*), and rename it to **Example data source change**.
3. Save the pipeline
3. Open the **tasks** for the **Test** stage
3. Add another **Power BI Action** task, and give it the following settings:
    * Power BI Service connection: select from the dropdown **Power BI for Azure DevOps**
    * Action: **Update DataSource connection**
    * Workspace Name: `demo-pbug-2023`
    * Check **Update all datasources in workspace**
    * Dataset name: *leave blank*
    * Data source: **SQL**
    * Old server: **wortellsmartlearning.database.windows.net**
    * New server: **wortellsmartlearning-test.database.windows.net**
    * Old database: **courses**
    * New database: **courses test**
3. Save the pipeline
3. Create a new release.

We're not there yet! It is true that the data source has been modified, but in our specific case other credentials are also required. Power BI Actions can also help you with this.

See if you can figure this out yourself - the details you'll need are as follows:

* Username: `testuser`
* Password: `WortellSmartLearning.nl!`

Of course, you only know if the new credentials work when you refresh the dataset without this causing errors. You can also control the refresh of the dataset via Power BI Actions.