# Setup

This lab will create a Kubernetes cluster using Google Container Engine (GKE) and will require connections to GitHub repositories. The following sections detail all the requirements you need in order to follow the Jenkins X lab.

## What you'll need

To complete this lab, you’ll need:

* A GitHub account to use for the Jenkins X configuration flow. This is mandatory, if you don't have one or you do not want to mess up your existing one, go now and [create one](https://github.com/join)
* Access to a standard internet browser (Chrome browser recommended).
* Time. It shouldn't take you more than 1,5 hours to read and finish everything (including setup), but depends on interruptions and how you plan your time. Then, plan your schedule so you have time to complete the lab. Follow the Google Cloud Shell tutorial in the right side of your screen 
* You need a Google Cloud Platform account or project. You can use a [Free Tier Google account to create one](https://cloud.google.com/free/) or your own. 
* If you already have your own GCP account, bear in mind that charges may apply if Free Tier is expired

## Google Cloud Shell tutorial

This lab tutorial is designed to be followed by [Cloud Shell Tutorials](https://cloud.google.com/shell/docs/tutorials), so you will be able to open by clicking the following button:

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/open?git_repo=https://github.com/dcanadillas/jenkins-x-lab&tutorial=labs/JXIntro.md)

You can also follow by reading this Markdown document locally or [in GitHub](https://github.com/dcanadillas/jenkins-x-lab) and executing the commands in your Google Cloud Shell:

* Open your [Google Console](https://console.cloud.google.com)
* Select or create the project where you are going to work in Google Cloud Platform
  
  ![Select Projec](https://raw.githubusercontent.com/dcanadillas/jenkins-x-lab/master/images/Select_GCP_Project.png)
* Open Google Cloud Shell terminal
  
  ![Cloud Shell](https://raw.githubusercontent.com/dcanadillas/jenkins-x-lab/master/images/OpenCloudShell.png)
* Work in your terminal and check that you are in the right project
  
  ![Cloud Shell Prompt](https://raw.githubusercontent.com/dcanadillas/jenkins-x-lab/master/images/CloudShell_ProjectPrompt.png)

If you follow this lab from the Google Cloud Shell Tutorial, you can copy all the commands to the shell just by clicking the copy icon.

<walkthrough-cloud-shell-icon>
</walkthrough-cloud-shell-icon>

Now you can [start the Jenkins X lab](./JXIntro.md):

[![Setup your environment](https://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/open?git_repo=https://github.com/dcanadillas/jenkins-x-lab&tutorial=labs/JXIntro.md)