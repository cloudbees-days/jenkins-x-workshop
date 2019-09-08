# Promote to Production

Let’s check the current releases that are deployed on the whole cluster:

```bash
jx get releases
```

Output (do not copy)

```sh
NAME            VERSION
jx-go-http        0.0.2
jx-go-http        0.0.1
```

And now let’s check current version deployed into staging

```bash
jx get version -e staging
```

Output (do not copy)

```sh
APPLICATION STAGING PODS URL
jx-go-http  0.0.2   1/1  http://jx-go-http.jx-staging.35.189.194.245.nip.io
```

Let’s say that we want to deploy version 0.0.2 into Production:

```bash
jx promote -a jx-go-http -e production -v 0.0.2
```

You may be asked for your GitHub credentials:
* Username for 'https://github.com': **Use your GitHub username**
* Password for 'https://<your_username>@github.com': **Use your API Token**
? Do you wish to use <previous_username>  as the user name to comment on issues **Press Enter for default value (Yes)**

The previous command is defined by different parameters:
* -a: The application to promote (jx-go-http in this lab)
* -e: The environment where the application is going to be promoted and deployed
* -v: The version of the application to promote/deploy

> **Note:** The promotion command can be executed with no parameters, so a wizard is going to ask about the actions to take from promotion taking the local repository
> 
> `$> jx promote `
> 
> ? Pick environment:  [Use arrows to move, space to select, type to filter]
   staging
> **production**
> ...

The promotion process takes different steps:
* Creates a PR in Production git repo (https://github.com/dcanadillas-kube/environment-jenkins-x-lab-production.git) to change the version in ‘env/requirements.yaml’ file
* Merges the PR to change the version in the Master branch of the Production repo
* Triggers a promotion pipeline build that deploys the application version (same as Production git repo) into Production namespace in Kubernetes

Once the promotion build pipeline finishes (you can check as previous steps with ‘jx get activity -f jx-go-http’), you can check that the 0.0.2 version of the app is deployed into Production:
And now let’s check current version deployed into different environments (staging and production):

```bash
jx get version
```

Output (do not copy)

```sh
APPLICATION    STAGING PODS URL                                                   PRODUCTION PODS URL
jx-go-http     0.0.2   1/1  http://jx-go-http.jx-staging.35.189.194.245.nip.ioo   0.0.2      1/1  http://jx-go-http.jx-production.35.189.194.245.nip.io
```

Congratulations! You have finished this lab.

If you want to clean your environment go to [Clean Up section](./CleanUp.md):
