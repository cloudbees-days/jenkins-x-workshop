# Create a Quickstart Project

Quickstarts are very basic pre-made applications you can start a project from, instead of starting from scratch.

You can create new applications from a list of curated Quickstart applications via the [`jx create quickstart` command](https://jenkins-x.io/commands/jx_create_quickstart/).

To see a list of all the quickstarts available run the following command:
```
jx create quickstart
```

Cancel that command with `ctrl+c` and now run the following command where the `-l go` will filter the list of available quickstarts to a specific language and the `-f http` will filter for text that is part of the project names - so the following command will result in a list of Golang projects with 'http' in their names:
```
jx create quickstart -l go -f http
```

In this case there is only one match so it will automatically choose that one for you and move right to setting it up.

When prompted with:

*? Do you wish to use ckcd-sa-bot as the Git user name? (Y/n)* -  choose the value n for "No". Do not choose the default value Y for "Yes".
‍

When prompted for:

*? Git user name?* - specify your own/usual GitHub account username.

*? GitHub user name:* choose the default value, which should be your own GitHub account username that you specified in the previous step.

*?* API Token:* - click on this [link](https://github.com/settings/tokens/new?scopes=repo,read:user,read:org,user:email,write:repo_hook,delete_repo) - logging in to GitHub with the same GitHub account used in the previus steps and enter the API token.

*? Enter the new repository name:* - this will be your project name and the name of the repository created for the project. We will all call 'go-http' but prefix it with our GitHub account username, so I would enter 'kmadel-go-http'. All of these repositories will be created in the same GitHub organization, so they must all have unique names.

*? Would you like to initialise git now?* Choose the value "Y" to initialize git for your new project.

*? Commit message:  (Initial import)* Just hit enter to execept the default commit message of "Initial import".

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

And you can take a look at your project in CKCD.

Now typically you would need to set up your computer with all the tools needed to makes changes to the code in the project and to be able to test those changes locally. In the [next exercise](./create-devpod.md) you will see how DevPods do all of that for you.