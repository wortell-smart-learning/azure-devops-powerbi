# Set up Azure DevOps Release pipeline

1. Go to Azure DevOps
2. Click on **Pipelines**
3. Click on **Releases**
4. Click "New Pipeline"

![Add new pipeline](img/21-pipelines-releases-new-pipeline.png)

> When you meet Azure DevOps gurus, they will generally stop using *release pipelines*. The reason for this is that within Azure DevOps, Microsoft is slowly making the distinction between "build" and "release" disappear. Instead come "multi-stage pipelines".
>
> However, for our purpose (structuring your Power BI deployments with Azure DevOps), this is the fastest way to get started.

![Click "Empty job"](img/22-pipelines-empty-job.png)

5. Click **Empty job**

Azure DevOps will now prompt you for the name of your **Stage**. An "stage" is easiest for us to translate as an "environment". For example a test environment.

6. Name your first stage "Test" and close the *pane*

![Rename your stage to "Test"](img/23-name-stage-test.png)

You will now see a screen with two parts:

* artifacts
* Internships

*Artifacts* are what you roll out over the environments. The idea of an "artifact" is that it is *immutable*: if I have approved something on a test environment, I want *exactly the same report* to appear on my production environment.

Under *Stages* you will see the newly created stage *Test*. Below that is the text `1 job, 0 tasks`.

At the top of your screen you will see a number of tabs within your release pipeline. Here you will find all kinds of settings.

We now first add an artifact. This is the starting point: in order to deploy a report somewhere, we have to get it from somewhere. Therefore, we first link the artifact:

![Click "Add artifact"](img/24-artifact-add.png)

7. Click on **Add** next to the **Artifacts** heading
8. Choose **Azure Repos Git** and enter the following settings:
    * **Project**: choose the project you are currently working on via the dropdown
    * **Source (repository)**: Choose from the dropdown the repository where you just placed the first Power BI file.
    * **Default branch** (it will be visible as soon as you select the repository): Choose `master` from the dropdown
    * Leave the other settings at the default values
    * Click on **Add**

![Add artifact - settings](img/25-add-artifact-settings.png)

You have now linked an **Artifact**. In concrete terms, this means that the various *stages* in your deployment pipeline receive the latest version of our developed report. A deployment on the test environment is therefore guaranteed with the same report as a deployment on the production environment.

Now that we have set up the *artifact*, we can set up a step-by-step plan for an *internship*.

9. Click on the text `1 job, 0 task`. The **Tasks** tab opens.

You now enter the tasks that are performed within your *stage*. Azure DevOps divides this into **jobs** and **tasks**.
A **job** is a collection of tasks that must be performed on a specific type of computer. You usually only use one job for the rollout of Power BI reports. This is already created for you by default.

The **tasks** are what needs to be done to get your *release* done.

8. Click on **Agent job**. You will now see a properties window appear on the right side. You should see the following settings here:

*Agent Pool: Hosted Windows 2019 with VS2019

![Agent job settings](img/26-agent-job-settings.png)

## Setting up the Stage

To actually automate the rollout of your Power BI report, there must be a step-by-step plan: the *tasks* list. This is described in [Setup Release Stage](06-set-up-devops-release-stage.md).