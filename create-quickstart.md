# Create a Quickstart Project

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
- `-p jx-go` will set *jx-go* as the application project name (application and git repo name)

 So, the following command will result in a list of Golang projects with 'http' in their names and will set the repo name in Git as *jx-go*:

```bash
jx create quickstart -l go -f http -p jx-go
```

In this case there is only one match so it will automatically choose that one for you and move right to setting it up.

When prompted with:

**? Do you wish to use ckcd-sa-bot as the Git user name? (Y/n)** -  choose the value n for "No". Do not choose the default value Y for "Yes".
‍

When prompted for:

**? Git user name?**- specify your own/usual GitHub account username.

**? GitHub user name:** choose the default value, which should be your own GitHub account username that you specified in the previous step.

**? API Token:**- enter your GitHub personal access token. If you don't have one then click on this [link](https://github.com/settings/tokens/new?scopes=repo,read:user,read:org,user:email,write:repo_hook,delete_repo) - logging in to GitHub with the same GitHub account used in the previus steps and enter the API token.

**? Enter the new repository name:** - this will be your project name and the name of the repository created for the project. We will all call 'go-http', so  enter **go-http**. 

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
jx get build logs kmadel/jx-go-http/master
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