# Creating your first JX install on GKE

## Let's get started!

This guide will show you how to install `jx`, use it to create a cluster on Google Kubernetes Engine and then explore the developer-centric features of Jenkins X.

Jenkins X version: 1.3.1073

**Time to complete**: About 80 minutes

Click the **Next** button to move to the next step.

## Installing Dependencies

The first thing we need to do is install the `jx` binary and add it to your PATH. The following command will execute a script that does that for you.

```bash
source ./install-jx.sh
```

**Tip**: Click the copy button on the side of the code box to paste the command in the Cloud Shell terminal to run it.

This may take a few minutes to complete as it downloads everything it requires.

## Create a cluster

To create the cluster, run the following:

```bash
jx create cluster gke --skip-login --default-admin-password=admin
```

This will guide you through creating a cluster on GKE.

### Missing Dependencies

JX will attempt to locate any required dependencies, if it discovers that some are missing
it will prompt to install them for you in the `~/.jx/bin` folder.  It is recommended that
you allow `jx` to install any missing dependencies.

### Configure your cluster

JX will then prompt you for the basic configuration options for your cluster, such as:

* Google Compute Zone - select a zone that is near to you
* Google Cloud Machine Type - recommended `n1-standard-2`
* Minimum number of Nodes - recommended `3`
* Maximum number of Nodes - recommended `5`
* Would you like use preemptible VMs - recommended `No`
* Would you like to access Google Cloud Storage / Google Container Registry - recommended `No`
* Would you like to enable Kaniko for building container images - recommended `No`
* (Optional) Would you like to enable Cloud Build, Container Registry & Container Analysis APIs - recommended `No`

### Creating the cluster

Once the cluster is created, you will be prompted for some configuration options:

* Install Ingress Controller - recommended `Yes`
* Domain Configuration - recommended `Use the default`

### GitHub connectivity

If this is the first time you have run `jx` in this cloudshell, `jx` will prompt you for a 
github username & api token.  If you already have one, simply enter the values when prompted. 
If you don't have an api token, click on the link provided to generated one and enter the 
token value into the prompt.

### Jenkins Installation

* Select Jenkins Installation Type - recommended `Static Jenkins Master`
* Pick workload build pack - recommend `Kubernetes Workloads: Automated CI+CD with GitOps Promotion`

Next, `jx` will attempt to configure Jenkins connectivity.  This should be done automatically, 
but sometimes Jenkins is not able to start intime.  In this instance, you will be asked to 
login to Jenkins using the admin user.  The password for the admin user will be displayed in the 
console.  At this point, follow the instructions to add the Jenkins API token.

## Create a Quickstart Project

Quickstarts are very basic pre-made applications you can start a project from, instead of creating a project from scratch.

You can create new applications from a list of curated Quickstart applications via the [`jx create quickstart` command](https://jenkins-x.io/commands/jx_create_quickstart/).

Before creating our quickstart application let's create a directory to work within.

```bash
mkdir -p ~/cloudbees_days/jx-workshop
```
```bash
cd ~/cloudbees_days/jx-workshop
```

Let's then be sure that all our files, local repos and projects are set from commands that are run from this directory.

 We will run a quickstart command whith following parameters:

- `-l go`  will filter the list of available quickstarts to a specific language - Go in this case -
- `-f http` will filter for text that is part of the quickstart project names
- `-p jx-go-http` will set *jx-go-http* as the application project name (application and git repo name)

 So, the following command will result in a list of Golang projects with 'http' in their names and will set the repo name in Git as *jx-go*:

```bash
jx create quickstart -l go -f http -p jx-go-http
```

In this case there is only one match so it will automatically choose that one for you and move right to setting it up.

When prompted with:

**? Do you wish to use ckcd-sa-bot as the Git user name? (Y/n)** -  choose the value n for "No". Do not choose the default value Y for "Yes".
‍

When prompted for:

**? Git user name?**- specify your own/usual GitHub account username.

**? GitHub user name:** choose the default value, which should be your own GitHub account username that you specified in the previous step.

**? API Token:**- enter your GitHub personal access token. If you don't have one then click on this [link](https://github.com/settings/tokens/new?scopes=repo,read:user,read:org,user:email,write:repo_hook,delete_repo) - logging in to GitHub with the same GitHub account used in the previus steps and enter the API token.

**? Enter the new repository name:** - this will be your project name and the name of the repository created for the project. We will all call 'jx-go-http', so  enter **jx-go-http**. 

**? Would you like to initialise git now?** Choose the value "Y" to initialize git for your new project.

**? Commit message:  (Initial import)** Just hit enter to execept the default commit message of "Initial import".

After you finish responding to the prompts a Jenkins X quickstart will automate all of the following for you:

 * creates a new application from the quickstart in a sub directory
 * add your source code into a git repository
 * create a remote git repository on a git service, such as GitHub
 * push your code to the remote git service
 * adds default files:
   * Dockerfile to build your application as a docker image
   * Jenkinsfile to implement the CI / CD pipeline
   * Helm chart to run your application inside Kubernetes
 * register a webhook on the remote git repository to your teams Jenkins
 * add the git repository to your teams Jenkins
 * trigger the first pipeline

 Watch pipeline activity via: 
```bash
jx get activity -f jx-go-http -w
```
Browse the pipeline log via: 
```bash 
jx get build logs <your github username>/jx-go-http/master
```
Open the Jenkins console via: 
```bash
jx console
```
You can list the pipelines via: 
```bash
jx get pipelines
```
When the pipeline is complete:
```bash
jx get applications
```

And you can take a look at your project in CKCD.

To see a list of all the quickstarts available in the current environment run the following command:

```bash
jx create quickstart
```

Cancel that command with `ctrl+c`.

## Create and Use a DevPod

Now typically you would need to set up your computer with all the tools needed to makes changes to the code in the project and to be able to test those changes locally. In this exercise you will see how **DevPods** do all of that for you.

A [DevPod](https://jenkins-x.io/developing/devpods/) allows you to develop in a K8s pod running in the same cluster where Jenkins X is running. DevPods allow you to build and test your Jenkins X application before you are ready to create a Pull Request - all without locally installing any developer tools. 

DevPods provide a terminal/shell that is based on the exact same operating system, docker containers and tools that are installed in the pod templates used in the Jenkins X CI/CD pipelines. This allows you to build, run tests or redeploy apps using the exact same tools as the CI/CD pipelines provided by Jenkins X build-packs and before you commit to your upstream Git repository.

Before creating a DevPod you want to be in the source code repository for which you want to make changes - the one create with the quickstart from the last exercise: `cd ./{GitHub username}-go-http` 

To create your own DevPod use the command [`jx create devpod`](https://jenkins-x.io/commands/jx_create_devpod/). Run the `jx create devpod` command to get a list of all available DevPods. Once you have reviewed the list cancel with `ctrl+c`.

For the workshop we want to create a simple **http Golang** project with the following command where the `-l go` specifies the programming language to supporet - but make sure you are in your quickstart repository directory that you created in the previous exercise:

```bash
jx create devpod -l go --username='[your GitHub username]'
```

This will then create a new DevPod based on the `go` based pod template and open your terminal inside that pod. You are now free to use the various pre-installed tools like git, docker, go, skaffold, jx which will all be using the same exact configuration as the automated Jenkins X CI/CD pipelines.

## Using the Theia IDE
DevPods have a `--sync` feature that will automatically sync local changes up to the DevPod. Any changes you make locally will be pushed up to the DevPod, built automatically, and then a temporary version of your application will be deployed to the Jenkins X cluster.

Instead of using `--sync` we will be using another cool features of DevPods - [an embedded web based IDE called Theia](https://www.theia-ide.org/).

Open the Theia IDE in your browser.

Make a change to the code.

Commit to a new branch.

Go to GitHub and create a PR to the master branch.

## Install CloudBees Core for Kubernetes CD
The CloudBees Core for Kubernetes CD addon provides a visual dashboard for your Jenkins X applications.

```bash
jx create addon cloudbees --basic
```

```bash
jx cloudbees
```

Click on the provided url to open CloudBees Core for Kubernetes CD. Loing with the username `admin` and password `admin`.

## Leveraging Preview Environments for Pull Requests

Preview environments provide temporary environments to review your changes as part of the Pull Request process.

