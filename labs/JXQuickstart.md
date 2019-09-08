# Create a Quickstart Project

Quickstarts are very basic pre-made applications you can start a project from, instead of creating a project from scratch. You can create new applications from a list of curated Quickstart applications via the jx create quickstart command.
Let's do that, but before creating our quickstart application create first a directory to store your work:

```bash
mkdir -p ~/jx-gke-lab && cd ~/jx-gke-lab
```

The following set of commands will be run from this directory.

Create now a Golang Quickstart with the following command:

```bash
jx create quickstart -l go -f http -p jx-go-http -b
```

Output (do not copy)

```
About to create repository jx-go-http on server https://github.com with user dcanadillas

Creating repository dcanadillas/jx-go-http
Pushed Git repository to https://github.com/dcanadillas/jx-go-http

Creating GitHub webhook for dcanadillas/jx-go-http for url http://hook.jx.35.187.61.201.nip.io/hook

Watch pipeline activity via:    jx get activity -f jx-go-http -w
Browse the pipeline log via:    jx get build logs dcanadillas/jx-go-http/master
You can list the pipelines via: jx get pipelines
When the pipeline is complete:  jx get applications

For more help on available commands see: https://jenkins-x.io/developing/browsing/
```

Note that your first pipeline may take a few minutes to start while the necessary images get downloaded!

Here's a brief explanation of what you just run:
* -l go will filter the list of available quickstarts to a specific language - Go in this case -.
* -f http will filter quickstarts in the previously selected language which name contains the string http
* -p jx-go-http will set jx-go-http as the application project name (application and git repo name). 
* -b launches the command in batch mode, so you do not need to interactively answer any questions

> **Note:** You can run the previous command without the ‘-b’ option (non-batch), so it uses the interactive mode. In this case you don’t need to use ‘-p jx-go-http’. The command would be like:
> 
> `$> jx create quickstart -l go`
> 
> In interactive mode you would be asked for the following:
> * **Git user name?** select your GitHub username that is going to develop and be the owner of the repo. This GitHub user can be different from the pipeline GitHub username that you used on Jenkins installation
> * **Which organisation do you want to use?** The GitHub organization where you want the repository to be created
> * **Enter the new repository name:** Enter a repository name that is going to be created. This step is the one that is selected with the -p option used in batch-mode
> **Would you like to initialise git now? (Y/n)** Type Y (or press Enter) to initialize git in the directory where the local repo is create
> **Commit message:  (Initial import)** Press Enter to select the default message “Initial import” or just type your first commit message of the repo to be created

By executing this command, Jenkins X has performed a set of actions belonging to this specific quickstart (you can follow the steps in the output the previous command generated):
* Based on the language selected it recognizes using [Draft](https://draft.sh/) the specific Jenkins X [buildpack](https://jenkins-x.io/architecture/build-packs/).
* Based on this buildpack it creates a new application in a local sub directory. 
* Adds your source code into a local git repository.
* Adds the following default files:
  * Dockerfile to build your application as a docker image.
  * `jenkins-x.yml` file implementing a Jenkins X CI/CD pipeline.
  * Helm chart to run your application inside Kubernetes (inside `charts/` directory).
  * Preview chart with dependencies to create preview environments (also inside `charts/` directory).
* Creates a remote git repository on a git service, such as GitHub (the one you just configured)
* Pushes your local code to the remote git service.
* Registers a webhook on the remote git repository.
* Triggers the pipeline for the first time.

Now run the following command to monitor the pipeline activity in watch mode (`-w` option):

```bash
jx get activity -f jx-go-http -w
```

Output (do not copy)

```
STEP                                               STARTED AGO DURATION STATUS
dcanadillas/jx-go-http/master #1                            2s          Running
  from build pack                                           2s          Running
    Credential Initializer 4xf98                            2s       0s Succeeded
    Working Dir Initializer G9qw7                                       Pending
    Place Tools                                                         Pending
    Build Container Build                                               Pending
    Build Make Build                                                    Pending
    Build Post Build                                                    Pending
    Git Merge                                                           Pending
    Git Source Dcanadillas Jx Go Http Master Wdbjl                      Pending https://github.com/dcanadillas/jx-go-http
    Promote Changelog                                                   Pending
    Promote Helm Release                                                Pending
    Promote Jx Promote                                                  Pending
    Setup Jx Git Credentials                                            Pending
dcanadillas/jx-go-http/master #1                            3s          Running
  from build pack                                           3s          Running
    Credential Initializer 4xf98                            3s       0s Succeeded
    Working Dir Initializer G9qw7                           1s       0s Succeeded
    Place Tools                                                         Pending
    Build Container Build                                               Pending
    Build Make Build                                                    Pending
    Build Post Build                                                    Pending
    Git Merge                                                           Pending
    Git Source Dcanadillas Jx Go Http Master Wdbjl                      Pending https://github.com/dcanadillas/jx-go-http
    Promote Changelog                                                   Pending
    Promote Helm Release                                                Pending
    Promote Jx Promote                                                  Pending
    Setup Jx Git Credentials                                            Pending

...
```

Up to this point, you didn't check what the pipeline you just launched is doing. However, you should see the steps now being executed and the status of the different steps. 
Press **CTRL+C** to exit the activity view watch mode.

To browse the pipeline detailed log, run the following jx command:

```bash
jx get build logs
```

When the pipeline is complete (meaning all activities have a Succeeded/Failed status), you can have a look at your deployed applications versions  in Jenkins X by typing:

```bash
jx get version
```

Output (do not copy)

```
APPLICATION STAGING PODS URL
jx-go-http  0.0.1   1/1  http://jx-go-http.jx-staging.35.187.61.201.nip.io
googlece33001_student@cs-6000-devshell-vm-cf22e372-df56-4e51-bb3c-7ebda2af30ed:~/jx-gke-lab/jx-go-http$
```

Now you can go to the [next section](./JXPullRequest.md):

<!-- [![Setup your environment](https://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/open?git_repo=https://github.com/dcanadillas/jenkins-x-lab&tutorial=labs/JXPullRequest.md) -->