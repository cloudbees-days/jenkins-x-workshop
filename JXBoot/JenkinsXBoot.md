# Installing Jenkins X using Boot

You can install also Jenkins X using its [new Boot feature](https://jenkins-x.io/getting-started/boot/), that means using GitOps for installation and cluster configuration upgrades. Instead of using `jx create cluster gke` or `jx install`, `jx boot` command gives you a more stable and consistent way of doing the installation and upgrades just by tracking/versioning the configuration file `jx-requirements.yml`

## Install your Jenkins X Distribution

At this point you may have installed the `jx` binary for Jenkins X CLI from [previous documentation](../labs/JXInstall.md):

```bash
./install-jx.sh -v 2.0.643
```

> **Note:**
> Don't use the `-v 2.0.643` parameter if you want to install latest version.
> If you want to use [CloudBees Jenkins X Distribution](https://www.cloudbees.com/products/cloudbees-jenkins-x-distribution) you can use the same script by executing:
> ```bash
> ./install-jx.sh -c
> ```

## Creating the cluster

JX Boot is going to isntall Jenkins X platform into an existing Kubernetes cluster, so first things first. Let's create a GKE cluster with the required scopes:

We are using Google `gcloud` command to [create the cluster in GKE](https://cloud.google.com/sdk/gcloud/reference/container/clusters/create). From the Cloud Shell the required command is the following:

```bash
export JX_CLUSTER=<your_desired_GKE_cluster_name>
```

```bash
gcloud container clusters create ${JX_CLUSTER} \
--machine-type n1-standard-2 \
--min-nodes 4 --max-nodes 6 \
--enable-autoscaling \
--zone europe-west1-c \
--scopes=monitoring,logging-write,cloud-platform,service-management,compute-rw,service-control,storage-full
```

> **Note:**
> You can also create the cluster using the `jx create` command:
> ```bash
> jx create cluster gke --skip-installation --advanced-mode --skip-login
> ```
> Following parameters are used in this command line execution:
> * **--skip-installation:** This avoids to install Jenkins X platform (remember that we are using `jx boot` for that)
> * **--advanced-mode:** This other parameter prompts you for all the configuration required for the cluster, so default values are not used (e.g. `min-nodes` or `machine-type`)
> * **--skip-login:** Just used because we are executing commands from Google Cloud Shell. In case you use any other terminal you don't need to add this parameter

## Forking and preparing the Boot repo

Jenkins X Boot uses a Jenkins X pipeline to install Jenkins X itself using Helm style configuration. And for that we need to clone a GitHub repo to get all the values.yaml and the Jenkins X pipeline definition. This repo is [located here](https://github.com/jenkins-x/jenkins-x-boot-config) or [use this for CloudBees Jenkins X Distribution](https://github.com/cloudbees/cloudbees-jenkins-x-boot-config)

So, we need to do the following:

* Fork in GitHub the `jenkins-x-boot-config` repo to your GitHub organization and change the name to something like `environment-<your_gke_cluster-name>-dev`
* Clone the new forked repo locally
  
  ```bash
  git clone git@github.com:<your_org>/environment-<your_gke_cluster-name>-dev
  ```

* Get into the cloned repo with `cd environment-<your_gke_cluster-name>-dev`
* Change the parameters in the `jx-requirements.yml`file
  
  ```yaml
  cluster:
    clusterName: <your_gke_cluster_name>
    environmentGitOwner: <your_GitHub_org>
    project: <your_GCP_project>
    provider: gke
    zone: <specify_GCP_zone>
    ...
  ...
  kaniko: true
  secretStorage: vault  
  storage:
  logs:
    enabled: true
    url: gs://jx-workshop-boot
  reports:
    enabled: true
    url: gs://jx-workshop-boot
  repository:
    enabled: true
    url: gs://jx-workshop-boot
  ...
  ```


Please, refer to [Jenkins X Boot docs](https://jenkins-x.io/getting-started/boot/) in order to know all specific parameters you can change and modify.

## Installing Jenkins X Platform

### Some requirements to think about

Git is used to configure and verify all the GitOps process to do the installation, and some legacy `git commands` are not supported. So we need to be sure about the following requirements:

* Git client version needs to be 2.15+. If executing from a Google Cloud Shell or a Debian Linux, the latest version from apt sources is 2.11, so you need to upgrade like:
  
  ```bash
  $ curl -LO https://github.com/git/git/archive/v2.22.0.zip git-2.22.zip
  $ unzip git-2.22.zip 
  $ cd git-2.22.0
  $ make prefix=/usr/local all
  $ sudo make prefix=/usr/local install
  ```

* Be sure that you have updated or pulled the changes from the original Boot repo:
  
  ```bash
  $ cd environment-<your_gke_cluster-name>-dev
  $ git pull https://github.com/cloudbees/cloudbees-jenkins-x-boot-config.git master --tags
  $ git push origin master --tags
  ```

### Deploying Jenkins X

Let's then check the Jenkins X profile for your Jenkins X installation. This should be already done by the Jenkins X installation script used from this repo, but you can change your profile anytime with:

```bash
jx profile oss
```

Or the following for the CloudBees Jenkins X Distribution

```bash
jx profile cloudbees
```

> **Note:**
> If you change the profile from an OSS version to CJXD (CloudBees Jenkins X Distribution) you need to be sure that the version of the Jenkins X CLI is the right one. It is recommended in this case to [reinstall the Jenkins X CLI from CloudBees](https://go.cloudbees.com/docs/cloudbees-jenkins-x-distribution/installation/linux/), or just using the [script provided](../install-jx.sh) in this repo with `install-jx.sh -c`.

Now it's time to deploy using Boot:

```bash
jx boot
```

You will be asked for several parameters during installation:

* _WARNING: TLS is not enabled so your webhooks will be called using HTTP. This means your webhook secret will be sent to your cluster in the clear. See https://go.cloudbees.com/docs/cloudbees-jenkins-x-distribution/tls/ for more information_
? Do you wish to continue? **Yes**
* ? Jenkins X Admin Username admin
* ? Jenkins X Admin Password **Type your desired admin password**
* ? Pipeline bot Git username **<your_GitHub_bot_user>**
* ? Pipeline bot Git email address **<GitHub_bot_user_email>**
* Pipeline bot Git token **Paste your API token for your GitHub bot user**
* HMAC token, used to validate incoming webhooks. Press enter to use the generated token **Press Enter**
* ? Do you want to configure an external Docker Registry? **No**

> **Note:**
> All this questions depend on the parameter values configured in the `jx-requirements.yml` and `env/parameters.yam`, which is going to be generated automatically the first time.

Output (do not copy)
```
booting up Jenkins X
Deleting and cloning the Jenkins X versions repo
Cloning the Jenkins X versions repo https://github.com/cloudbees/cloudbees-jenkins-x-versions.git with revision 0c3237feef3846fdfc7f17d4f5946017882414e2 to /Users/david/.jx/jenkins-x-versions
Desde https://github.com/cloudbees/cloudbees-jenkins-x-versions
 * branch            0c3237feef3846fdfc7f17d4f5946017882414e2 -> FETCH_HEAD

STEP: validate-git command: /bin/sh -c jx step git validate in dir: env

Git configured for user: dcanadillas and email dcanadillas@cloudbees.com

STEP: verify-preinstall command: /bin/sh -c jx step verify preinstall in dir: env

Connecting to cluster jx-workshop-boot
Will create public environment repos, if you want to create private environment repos, please set environmentGitPrivate to true jx-requirements.yaml

...
...

POD                                                STATUS
crier-86f5ff6ff7-xqw8b                             Running
deck-75c5d5c567-5psfc                              Running
deck-75c5d5c567-9nm6h                              Running
hook-6c7cd95cc5-2ftdc                              Running
hook-6c7cd95cc5-n2c6f                              Running
horologium-5dd8467c6-dklbc                         Running
jenkins-x-chartmuseum-75d45b6d7f-4r48h             Running
jenkins-x-controllerbuild-6dfccd7bff-rqdsq         Running
jenkins-x-controllerrole-5668ccc9-2pns8            Running
jenkins-x-gcactivities-1568147400-79ctw            Succeeded
jenkins-x-gcactivities-1568149200-z89fz            Succeeded
jenkins-x-gcpods-1568149200-5knlc                  Succeeded
jenkins-x-gcpreviews-1568149200-qwptp              Succeeded
jenkins-x-heapster-6586795784-m2p52                Running
jenkins-x-nexus-6ccd45c57c-5hn8z                   Running
jx-vault-jx-workshop-b-0                           Running
jx-vault-jx-workshop-b-configurer-6855bb8857-xmpnp Running
pipeline-f94ccb9d5-579fs                           Running
pipelinerunner-f8684cddc-hbxff                     Running
plank-6c8fdc8b66-xrh4p                             Running
prow-build-7dd49d9d65-kgrm7                        Running
tekton-pipelines-controller-54fddb69b9-6n7tk       Running
tide-c74457c84-7dm7j                               Running
vault-operator-55885856f8-nvbcc                    Running
verifying the git Secrets
verifying git Secret jx-pipeline-git-github-github
verifying username dcanadillas-kubecd at git server github at https://github.com
found 2 organisations in git server https://github.com: dcanadillas-kube, jx-dcanadillas
Validated pipeline user dcanadillas-kubecd on git server https://github.com
git tokens seem to be setup correctly
valid: there is a Secret: kaniko-secret in namespace: jx
installation is currently looking: GOOD
switching to the namespace jx so that you can use jx commands on the installation
Using namespace 'jx' from context named 'gke_emea-sa-demo_europe-west1-d_jx-workshop-boot' on server 'https://104.199.62.127'.
```

Check that your Jenkins X cluster is deployed:

```bash
jx get env
```

Output (do not copy)
```
NAME       LABEL       KIND        PROMOTE NAMESPACE     ORDER CLUSTER SOURCE                                                                          REF    PR
dev        Development Development Never   jx            0             https://github.com/dcanadillas-kube/environment-jx-workshop-boot-dev.git        master
staging    Staging     Permanent   Auto    jx-staging    100           https://github.com/dcanadillas-kube/environment-jx-workshop-boot-staging.git    master
production Production  Permanent   Manual  jx-production 200           https://github.com/dcanadillas-kube/environment-jx-workshop-boot-production.git master
```

Now you can continue with the lab [creating your first quickstart application](../JXQuickstart.md).

Or relaunch the Cloud Shell Tutorial and go to **Step 4**:

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/open?git_repo=https://github.com/dcanadillas/jenkins-x-workshop&tutorial=JenkinsXTutorial.md#create-a-quickstart-project)