# Getting Started

The Jenkins X cluster that you will be using today has the [CloudBees addon](https://jenkins-x.io/commands/jx_create_addon_cloudbees/) installed, providing CloudBees Core for Kuberenetes CD (CKCD). One feature of CKCD is that it provides single-sign-on. This will allow more than one user to use the same Kubernetes cluster with Jenkins X rather than creating a cluster for every developer.

You should already have the Jenkins X `jx` CLI installed (if not follow [these instructions](https://jenkins-x.io/getting-started/install/)). Open a terminal on you computer and run the following command to login to the cluster we will be using today:

```
jx login --url https://core.jx.ckcd.beedemo.net/
```

When you run this command it will install some additional dependencies if you don't already have them installed on your computer. These include:
 * `kubectl`
 * `helm`
 * `terraform`

If you already have any of these dependencies installed then you will want to make sure they are at the following version:
 * `kubectl` client version v1.13.2
 * `helm` version: 2.12.2
 * `terraform` version v0.11.11

The `jx login` command will onboard you into the CKCD application and update your local Kubernetes client configuration to allow running `jx` CLI commands against the workshop cluster. 

Once you have successfully run that command the CKCD application should open in your default browser - if not, navigate to https://core.jx.ckcd.beedemo.net/ and login with your GitHub credentials.

The output of the command in your terminal should look something like the following:
```sh
You are successfully logged in. You credentials are stored in ~/.kube/config file.
Using team 'jx' on server 'https://.........'.
```

Now you are ready to move on to the [next exercise to create a Jenkins X application using a Jenkins X Quickstart](./create-quickstart.md).

