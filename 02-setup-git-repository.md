# Setting up of a Git repository

## Background

You would prefer to secure important Power BI reports in version management. This makes it easier to undo changes. And that in turn makes you more free to develop without fear of losing things.

In Azure DevOps, version control is handled in **Azure DevOps Repos**. Within Azure DevOps Repos, **Git** is the standard way of versioning. This works seamlessly with Azure DevOps Pipelines, where we will automate the builds and releases later.

We won't go too deep into Git today. It is important to realize, however, that in Git it is convenient and common to maintain several *repositories*: in fact, every piece that you would like to be able to release separately is given its own repository.

For some teams this means that you create a repository per report. Other teams opt for a repository per group of reports (e.g. per customer group), or even choose to put all reports in one repository.

Within Azure DevOps, there is no limit on the number of Git repositories.

## Create a Git repository

Your first Git repository is created automatically by Azure DevOps. So if you just set up an *organization* and *project*, you will automatically have been gifted a Git repository with the same name as the project.

## Creating a new Git repository

We create a Git repository for a report that we will use in this training to make deployments. To do this, carry out the following steps:

1. Choose **Repos** in the left side
2. Click **at the top of the screen** on the **dropdown** next to the selected repository
3. Choose **New Repository**

![Create a new repository](img/06-new-repository.png)

4. Give the repository a name, for example `sample-pbi-deployment`. Leave the other settings unchanged. Click **Create**

![Name the new repository](img/07-new-repository-name.png)
