# Power BI in Git

Now that we've made a local *clone* of the Git repository, we can use it to version control files.
We won't go into Git that much in the precon, but keep these two things in mind:

1. When you modify a file in the folder, it is not automatically versioned. For that you have to make a **commit**.
2. When you do a *commit* your file is only **locally** under version control. To bring it to Azure DevOps you do a **push**.

## Your first Power BI file in Git

1. Copy the file [Dashboard Wortell Smart Learning.pbix](https://github.com/wortell-smart-learning/devopspowerbi/raw/master/Dashboard%20Wortell%20Smart%20Learning.pbix) to the folder where you previously *clone* the repository
2. Open GitAhead

As you can see, a new block "uncommitted changes" has been added to the left of the middle. As mentioned above you have to make a *commit* to bring it under version control.

![Uncommitted changes in the GitAhead screen](img/15-uncommitted-changes.png)

3. Briefly describe what you did in the "commit message" box
4. Check the newly added report
5. Click on **commit**

![Commit commit in GitAhead](img/16-commit-doorvoeren.png)

6. The Power BI file is now versioned, but only locally on your computer. Open Azure DevOps, and verify that you don't see the Power BI file there yet.

![No PBI file in DevOps](img/17-geen-pbi-in-azure-devops.png)

7. Now click on the "Push" button in GitAhead at the top of the toolbar. This one has a red ball to indicate a commit is ready to be pushed:

![Push changes in GitAhead](img/18-push-changes.png)

8. You have now also shared the changes you made locally in version control with the server. Open Azure DevOps, and verify that the Power BI file is now visible there.

![Power BI in DevOps visible](img/19-pbi-in-devops-zichtbaar.png)

## Conclusion

You now have a basic way of working with version management:

* Make changes to your working directory (new files, modified files)
* Commit with e.g. GitAhead
* Push "send" to the server

Finally, when you collaborate with colleagues on a report, it is good to realize that the changes in Azure DevOps do not automatically end up on your computer! You can get the latest changes from Azure DevOps via the **Pull** button in GitAhead:

![Pull button in GitAhead](img/20-pull-git-ahead.png)