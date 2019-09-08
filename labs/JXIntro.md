# Jenkins X introduction

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/open?git_repo=https://github.com/dcanadillas/jenkins-x-lab&tutorial=JenkinsXTutorial.md)

[Jenkins X](https://jenkins-x.io/) is the Cloud Native implementation of Jenkins. By leveraging Kubernetes and using CRDs (Custom Resource Definitions) it allows you to execute your CI/CD pipelines with no expert Kubernetes knowledge required. It uses containers orchestration and development buildpacks to automate the development experience to deliver your applications.

The following concepts and components are essential in order to understand Jenkins X capabilities:

* [GitOps](https://www.weave.works/technologies/gitops/) promotions to promote your application
* [DevPods](https://jenkins-x.io/developing/devpods/) to provide development tools in sync with promotion environments
* [Build packs](https://jenkins-x.io/architecture/build-packs/) as development templates
* Powerful CLI to automate the CI/CD process and to provide Kubernetes tooling abstraction
* Automated [preview environments](https://jenkins-x.io/developing/preview/) to support pull or change requests
* [Jenkins X pipeline](https://jenkins-x.io/architecture/jenkins-x-pipelines/) engine for serverless capabilities (based on [Tekton CD](https://cloud.google.com/tekton/))

In this lab you will use Jenkins X as the Cloud Native CI/CD orchestrator to deploy a quickstart [Go application from a build pack](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/tree/master/packs/go) and use some of the Jenkins X features to work on a change request that needs to be delivered into production.

## What you’ll do

* Install Jenkins X in a GKE Cluster
* Use Kubernetes namespaces in GKE as deployment environments
* Create a Quickstart Project from a build pack
* Leverage Preview Environments for Pull Requests
* Promote your changes into Production

GitOps promotions is applied for all the development process to promote the application:

[![GitOps Image](https://raw.githubusercontent.com/dcanadillas/jenkins-x-lab/master/images/JXGitOps.png)](https://raw.githubusercontent.com/dcanadillas/jenkins-x-lab/master/images/JXGitOps.png)

* By creating a Pull Request the preview chart included in the buildpack is applied and deployed in a namespace that Jenkins X creates automatically as Preview Environment
* When the pull request is merged (it is done automatically in serverless by using ChatOps in GitHub) Jenkins X deploys into Staging by changing the version in Staging Git repo and then deploying the application chart in the staging namespace in Kubernetes
* Once a promotion to Production is triggered (needs to be triggered manually as a production environment) Jenkins X creates a pull request in the production Git repo to change the version, merges it and then deploy the chart into Production namespace in Kubernetes.

> **Note:**
> If no parameter is specified Jenkins X by default creates a namespace per environment in the same Kubernetes cluster (jx, jx-staging and jx-production). In this lab this default behaviour is used.But a more real scenario would be using different K8s clusters per environment. This can be done in Jenkins X by using ‘--remote-environments’ parameter when creating the cluster or just ‘--remote’ when editing current environments. This is possible by the Multi-cluster capabilities of Jenkins X_

Now you can go to the [next section](./JXInstall.md):

<!-- [![Setup your environment](https://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/open?git_repo=https://github.com/dcanadillas/jenkins-x-lab&tutorial=labs/JXInstall.md) -->