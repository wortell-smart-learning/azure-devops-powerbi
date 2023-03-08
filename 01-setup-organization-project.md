# Setup Guide Azure Devops for Power BI

## Introduction

This **Setup Guide** provides step-by-step instructions on how to set up your first Azure DevOps environment. **If you already have an *organization* and *project* within Azure DevOps you can skip this setup guide**.

## Roadmap

The step-by-step plan generally looks like this:

1. Set up Azure DevOps organization
2. Set up Azure DevOps project

## Step-by-step plan in detail

Below we go through the various steps in detail

### Set up Azure DevOps organization

* Go to [dev.azure.com](https://dev.azure.com/)
* Log in with an account that can be used for training.
   * When allowed, you may use an account from your organization.
   * You can also use an existing Microsoft or GitHub account, or create one for one.

| As a training provider you can log in here with an account in the domain where (temporary) student accounts may also exist.

When you log in to Azure DevOps for the first time, you will be presented with the "get started with Azure DevOps" screen:

![Screen with extra data on first login](img/01-first-use.png)

If you have previously used Azure DevOps, you will not encounter this screen, but you can immediately create a new *Organization*.

Now create a new *Organization* by choosing **New Organization** at the bottom of the list of existing *organizations*.

![Link "New Organization"](img/02-new-organization.png)

You will now see the **Get started with Azure DevOps** screen. Click **continue**.

![Get started with Azure DevOps](img/03-get-started-with-azure-devops.png)

Give your *organization* a name, and fill in the captcha correctly if necessary.

![Name your Azure DevOps organization](img/04-name-devops-org.png)

### Requesting a "free tier"

You want to use Azure DevOps for the deployment of Power BI reports. Performing that deployment, however, requires that there must be a computer running somewhere in the world that can do it for you.

Microsoft has built in a so-called "free tier" here: you can get 1800 minutes of DevOps Pipelines per month for free per organization. **If you don't have the "free tier", you have to set up or rent a server yourself - otherwise you can't use deployment pipelines.**

A free tier request can be made using this form: [https://forms.office.com/pages/responsepage.aspx?id=v4j5cvGGr0GRqy180BHbR63mUWPlq7NEsFZhkyH8jChUMlM3QzdDMFZOMkVBWU5BWFM3SDI2QlRBSC4u](https://forms.office.com/pages/responsepage.aspx?id=v4j5cvGGr0GRqy180BHbR63mUWPlq7NEsFZhkyH8jChUMlM3QzdDMFZOMkVBWU5BWFM3SDI2QlRBSC4u)

Important:

* **Read the form carefully** (so you don't accidentally enter a URL instead of your organization name)
* These are **private** projects

After submitting this form you will receive an e-mail within a few working days.

This is only about the piece of the **DevOps Pipelines**. You can therefore simply follow the rest of this step-by-step plan, and you can also use DevOps Repos as usual.

### Provision Azure DevOps project

With the new *organization* open in the left side of the screen, you will see the following screen on the right side:

![Create a project to get started](img/05-create-project-to-get-started.png)

Give the project a name, and click on **Create project**