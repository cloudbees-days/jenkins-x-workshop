# Jenkins X and CloudBees Core for Kubernetes CD Developers Workshop
In this workshop you will discover how Jenkins X and CloudBees Core for Kubernetes (K8s) CD can help you deliver streamlined workflows for cloud native applications on Kubernetes with Jenkins Pipelines and pre-production environments created automatically.

## Workshop Content
Please review the workshop prerequisites before proceeding to any exercises.
* [Getting Started](./getting-started.md)
* [Create a Quickstart Project](./create-quickstart.md)
* [Create and Use a DevPod](./create-devpod.md)
* [Using the Theia IDE](./theia-ide.md)
* [Leveraging Preview Environments for Pull Requests](./preview-environments.md)

## Workshop Prerequisites

In order to follow along with the hands on portion of the workshop, attendees should have the following resources available to them and tools installed:

  * A basic understanding of Jenkins Pipelines: https://jenkins.io/doc/book/pipeline/getting-started/ 
  * A basic understanding of Kubernetes: https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/ 
  * Internet access to include access to https://github.com to include the ability to access and use [the GitHub File Editor](https://help.github.com/articles/editing-files-in-your-repository/)
  * An account on Github.com and a basic understanding of how to use Github to do things like fork a repository, edit files in the web UI, and create pull requests
  * A personal access token for your Github account ([Github-Personal-Access-Token.md](Github-Personal-Access-Token.md)) with the following permissions:
    - repo: all
    - admin:repo_hook: all
    - admin:org_hook
    - user: all
  * [Git](https://git-scm.com/) locally installed
  * Install the `jx` cli: https://jenkins-x.io/getting-started/install/ 
    - NOTE: During the workshop `jx` will install some additional dependencies if you don't already have them installed on your computer. These include:
      * `kubectl`
      * `helm`
      * `terraform`
    * If you already have any of these dependencies installed then you will want to make sure they are at the following versions:
      * `kubectl` client version v1.13.2
      * `helm` version: 2.12.2
      * `terraform` version v0.11.11 
  * Typically a K8s cluster with Jenkins but if you would like to complete this workshop on your own you can follow the [instructions here](https://go.cloudbees.com/docs/cloudbees-core/kubernetes-cd-install-guide/) to create your own Jenkins X Kubernetes cluster.

## Disclaimer

Although the examples and code in this repository were originally created by employees of CloudBees, Inc. to use in training customers, your use of this material is not sponsored or supported by CloudBees, Inc.

## Contributors 

* Contributor: [Kurt Madel](https://github.com/kmadel)
 
## Questions, Feedback, Pull Requests Etc.

If you have any questions, feedback, suggestions, etc. please submit them via issues or, even better, submit a Pull Request!

