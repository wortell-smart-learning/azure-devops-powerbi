# Use and install Git locally

## Installing Git tooling

To use Git locally on Windows, we need to install the Git executable. There are 1001 Git clients, and which one you use depends a lot on what is supported in your organization, what you're used to, and how you want to use Git.

Since we don't want to focus so much on Git today, we choose a simple Git client: **GitAhead**.

Download and install GitAhead from [https://gitahead.com/](https://gitahead.com/).

## Clone from repository

The folder of stuff that is "versioned" is called a *repository* in Git. To get started, you *clone* a repository. This will give you the full repository (including history) on your local environment.

To do this, take the following steps:

1. In Azure DevOps Repos, open the appropriate repository (for example `sample-pbi-deployment`)
2. Click on **Clone** at the top right

![The 'clone' button in Azure DevOps Repos](img/08-clone-repo-button.png)

3. Copy the URL. Leave the Clone Repository window open!
4. Open GitAhead
5. Choose **Clone repository** in the GitAhead screen

!["Clone repository" in GitAhead](img/09-clone-repo-gitahead-button.png)

6. Paste the newly copied URL from Azure DevOps into the "URL" box.
    * **Remove the username before the `@`**.
    * The URL no longer looks like 'https://blabla@dev.azure.com/...', but instead looks like 'https://dev.azure.com/...'
    * (If you don't do this, GitAhead will continuously ask for login information)
    * Click **Next**

![Paste the URL into GitAhead](img/10-clone-repo-gitahead-pasteurl.png)

7. If desired, adjust the directory to a place that makes sense to you (this should be an empty directory!).
    * Leave the name unchanged!
    * For example, you could put the repository on the desktop for quick access during the course
    * You can move the folder elsewhere later, everything you need for Git is in that folder
    * Click on **Clone** when you have selected the correct folder

![Choose a directory in the GUI](img/11-clone-repo-move-directory.gif)

**GitAhead will now ask for your credentials**. We will create these within Azure DevOps:

8. Within the opened Azure DevOps "clone" screen, choose **Generate Git credentials**:

![Generate Git Credentials button](img/12-generate-git-credentials-button.png)

9. Copy the username and password, and paste them into GitAhead's credentials box. Click **OK**:

![Git generated credentials](img/13-git-generated-credentials.png)

![Git credentials in GitAhead](img/14-git-credentials-in-gitahead.png)