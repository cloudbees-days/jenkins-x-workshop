# Creating your first JX install on GKE

## Let's get started!

This guide will show you how to install `jx`, use it to create a cluster on Google Kubernetes Engine and then explore the developer-centric features of Jenkins X to include:

* Instaling CloudBees Core for Kubernetes CD (CKCD)
* Creating a Quickstart Project
* Creating and using a DevPod
* Using the Theia IDE web based IDE
* Leveraging Preview Environments for Pull Requests

>NOTE: It is recommended that your [create a GitHub Organization](https://help.github.com/en/articles/creating-a-new-organization-from-scratch) specifically for this workshop.

**Time to complete**: About 75 minutes

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
jx create cluster gke --no-tiller --skip-login --default-admin-password=admin
```

This will guide you through creating a cluster on GKE.

### Missing Dependencies

JX will attempt to locate any required dependencies, if it discovers that some are missing
it will prompt to install them for you in the `~/.jx/bin` folder.  It is recommended that
you allow `jx` to install any missing dependencies.

### Configure your cluster

JX will then prompt you for the basic configuration options for your cluster, such as:

* What type of cluster would you like to create `Zonal`
* Google Compute Zone - select a zone that is near to you
* Google Cloud Machine Type - recommended `n1-standard-8`
* Minimum number of Nodes - recommended `3`
* Maximum number of Nodes - recommended `5`
* Would you like use preemptible VMs - recommended `No`
* Would you like to access Google Cloud Storage / Google Container Registry - recommended `No`
* Would you like to enable Kaniko for building container images - recommended `Yes`
* (Optional) Would you like to enable Cloud Build, Container Registry & Container Analysis APIs - recommended `No`

### Creating the cluster

Once the cluster is created (this will take a few minutes), you will be prompted for some configuration options:

* Please enter the name you wish to use with git: `enter your GitHub username`
* Please enter the email address you wish to use with git: `enter any valid email address`
* Install Ingress Controller - recommended `Yes`
* Domain Configuration - recommended `Use the default`

### GitHub connectivity

If this is the first time you have run `jx` in this cloudshell, `jx` will prompt you for a 
github username & api token.  If you already have one, simply enter the values when prompted. 
If you don't have an api token, click on the link provided to generated one and enter the 
token value into the prompt. You may be prompted for your GitHub api token twice, make sure 
you enter the same token.

* Do you wish to use GitHub as the pipelines Git server: `Yes`

### Serverless Jenkins X Pipeline with Tekton Installation

* Select Jenkins Installation Type - select `Serverless Jenkins X Pipelines with Tekton`
* Pick workload build pack - select `Kubernetes Workloads: Automated CI+CD with GitOps Promotion`

Next, `jx` will install Prow and Tekton (among other components).

* Select the organization where you want to create the environment repository: enter `the GitHub org name you created for  workshop`

### What did Jenkins X install?

Now let's take a look at what got installed.

```bash
kubectl -n jx get pods
```

## Install CloudBees Core for Kubernetes CD (CKCD)
The CloudBees Core for Kubernetes CD addon provides a visual dashboard for your Jenkins X applications.

CKCD is installed as a Jenkins X addon called `cloudbees`. Run the following command to install CKCD on 
your Jenkins X cluster:
```bash
jx create addon cloudbees --basic
```
When prompted for:

* CloudBees Preview username - enter username provided by instructor
* CloudBees Preview password - enter password provided by instructor

After the addon installed successfully, run the following command to get the URL for CKCD:
```bash
jx cloudbees
```

Click on the provided url to open CloudBees Core for Kubernetes CD. Login with the username `admin` and password `admin`.
If the service isn't available yet run the following command to get the status of the CKCC addon:
```bash
kubectl get pods 
```

>NOTE: There may be a small issue where you have to update the container images for the CloudBees addon by patching the pod - replacing {core-pod-id} with the id of your core pod:

```bash
kubectl patch pod/{core-pod-id}  -p '{"spec":{"containers":[{"name":"core-frontend","image":"docker.io/jenkinsxio/core-frontend:0.0.612"},{"name":"core-backend","image":"docker.io/jenkinsxio/core-backend:0.0.210"}]}}'
```

## Create a Quickstart Project

Quickstarts are very basic pre-made applications you can start a project from, instead of creating a project from scratch.

You can create new applications from a list of curated Quickstart applications via the [`jx create quickstart` command](https://jenkins-x.io/commands/jx_create_quickstart/).

Before creating our quickstart application let's create a directory for our work.

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

 So, the following command will result in a list of Golang projects with 'http' in their names and will set the repo name in Git as *jx-go-http*:

```bash
jx create quickstart -l go -f http -p jx-go-http
```

In this case there is only one match so it will automatically choose that one for you and move right to setting it up.

When prompted with:

  * Do you wish to use kmadel as the Git user name? -  select `Y`
  * Which organisation do you want to use? - enter `the GitHub org name you created for this workshop`
  * Enter the new repository name: enter `jx-go-http`
  * Would you like to initialise git now? select `Y`
  * Commit message: it return for default

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
jx get build logs
```
Select your pipeline from the list.

You can list the pipelines via: 
```bash
jx get pipelines
```
When the pipeline is complete:
```bash
jx get applications
```

And you can take a look at your pipeline in CKCD.

## Create and Use a DevPod

Now typically you would need to set up your computer with all the tools needed to makes changes to the code in the project and to be able to test those changes locally. In this exercise you will see how **DevPods** do all of that for you.

A [DevPod](https://jenkins-x.io/developing/devpods/) allows you to develop in a K8s pod running in the same cluster where Jenkins X is running. DevPods allow you to build and test your Jenkins X application before you are ready to create a Pull Request - all without locally installing any developer tools. 

Before creating a DevPod you want to be in the source code repository for which you want to make changes - the one created with the quickstart from the last exercise: 
```bash
cd ./jx-go-http
``` 

To create your own DevPod we will use the command [`jx create devpod`](https://jenkins-x.io/commands/jx_create_devpod/).

For the workshop we are using the **http Golang** quickstart project. We will create a DevPod with the `-l go` argumeent, specifying the programming language to support - make sure you are in your quickstart repository directory that you created in the previous exercise:

```bash
jx create devpod -l go
```

This will then create a new DevPod based on the `go` based pod template and open your terminal inside that pod. You are now free to use the various pre-installed tools like git, docker, go, skaffold, jx which will all be using the same exact configuration as the automated Jenkins X CI/CD pipelines.

Run the following command to see all the containers running in your DevPod:
```bash
kubectl describe pod/kmadel-go -n jx
```

## Using the Theia IDE
DevPods have a `--sync` feature that will automatically sync local changes up to the DevPod. Any changes you make locally will be pushed up to the DevPod, built automatically, and then a temporary version of your application will be deployed to the Jenkins X cluster.

Instead of using `--sync` we will be using another cool features of DevPods - [an embedded web based IDE called Theia](https://www.theia-ide.org/).

Open the Theia IDE in your browser.
```bash
jx get urls
```
Click on the URL for Theia.

## Leveraging Preview Environments for Pull Requests

Preview environments provide temporary environments to review your changes as part of the Pull Request process.

Create a new branch for the pull request and check it out in your DevPod shell:
```bash
git checkout -b my-pr
```

>NOTE: In the Theid IDE the Git branch changed in the lower left.

Update the `main.go` file in Theia.

* Update line 10 to: `title := "Jenkins X golang http example by <your name>"`
* The Theid IDE will automatically save your changes and sync them with the files in your DevPod

In your DevPod shell:
* Stage the change for commit:
```bash
git add main.go
```
* Commit the changes to GitHub:
```bash
git commit -m "This is a PR"
```
* Push the changes to GitHub:
```bash
git push --set-upstream origin my-pr
```
* Use the **jx** CLI to create a GitHub PR:
```bash
jx create pr -t "My PR" \
  --body "This is the text that describes the PR
and it can span multiple lines" -b
```

Open the link that is the output of that command.

Check the progress of the PR build via:
```bash
jx get activity
```

Get the preview environments:
```bash
jx get previews
```
Check the output of your updated application:

* Open CKCD and go to the *Environments* screen
* Click on the *Preview* button of your *jx-http-go* application under the *Development* environment

Merge the PR:

* Open the pull request screen in GitHub
* Add a `/approve` comment to your PR.
* Prow's Tide component will auot-merge the PR for you and deploy your application to your Staging environment.

View automatice deployment to staging environment:

```bash
jx get activity -f jx-go-http -w
```

You will also see it updated in CKCD.

## Use CKCD to Promote to Production

Open CKCD in your browser and go to the *Environments* screen. 
Your instructor will walk you through using CKCD to promote applications between *Staging* 
and *Production* environments.



