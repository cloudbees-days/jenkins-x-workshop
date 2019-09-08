# Doing a pull request

Once we checked that our first 0.0.1 version is deployed into Staging, let’s change our application in a different git branch and create a pull request to merge into master.

## Creating the GitHub Pull Request

Let’s get into the local git repo:

```bash
cd ~/jx-gke-lab/jx-go-http
```

Then, create a new branch for the pull request and check it out from your Cloud Shell:

```bash
git checkout -b my-pr
```

Open the Cloud Shell editor and update the main.go file:

```bash
cloudshell edit main.go
```

The Cloud Shell editor should open the file, that you can now edit graphically.  Update line 10 so it the variable title has a new value. The new line should like like this:

        title := "Jenkins X golang http example by <your name>"

When done, press Ctrl + S (or Command + S if you're using a Mac).
Now, stage the change for commit and commit the change to GitHub:

```bash
git add main.go
git commit -m "New welcome message"
```

Finally, push the changes to GitHub:

```bash
git push --set-upstream origin my-pr
```

Now we are ready to create the Pull Request (PR). So, let’s use the GitHub web console to create the pull request with the changes you pushed from your “my-pr” branch:
* Go to https://github.com/<your_github_username>/jx-go-http
* Check that your changes are waiting for creating the PR and select “Compare & pull request” (DON’T FORGET TO SIGN IN INTO GITHUB!)
* Then edit your PR message (e.g. “New welcome message”)
* Check your changes 

Here you have some screenshots to see the process:

![Compare and PR in GirHub](https://raw.githubusercontent.com/dcanadillas/jenkins-x-lab/master/images/GitHubPR.png)

![Create a GitHub PR](https://raw.githubusercontent.com/dcanadillas/jenkins-x-lab/master/images/GHCreatePR.png)

> **Note:** Instead of using GitHub web console you can also create the pull request directly from Jenkins X with the following command
> 
> `$> jx create pr -t “New welcome message” `
> 
> Open then the link that is the output of the command and you go directly to the pull request created.

## Preview the application and approve the Pull Request

Once the Pull Request is created on GitHub we sould use the Prow commands to approve the pull request via ChatOps, so then the merge and pipelines are triggered automatically once one of the approvers in the “OWNERS” file of the application repo select `/approve` or `/lgtm` (Looks Good to Me). 

The following actions happened automatically when we created the PR:
* An approval notifier is saying that “This PR is NOT APPROVED” and suggest some ChatOps commands that can be used from Prow
  
![Approval Notifier in GitHub](https://raw.githubusercontent.com/dcanadillas/jenkins-x-lab/master/images/GHPRApprovalNotifier.png)
  
* Then, a size label is attached to the change proposed in the PR (size/XS) in this case

![Automated Jenkins X label](https://raw.githubusercontent.com/dcanadillas/jenkins-x-lab/master/images/GHLabel.png)

* After a minute more or less a Preview environment is created and deployed

![Automated Jenkins X label](https://raw.githubusercontent.com/dcanadillas/jenkins-x-lab/master/images/GHPreviewPR.png)

Check the progress of the PR build:

```bash
jx get activity -f dcanadillas/jx-go-http/PR-1
```

Output (do not copy)

```
STEP                                                 STARTED AGO DURATION STATUS
dcanadillas/jx-go-http/PR-1 #1                            15m29s      57s Succeeded
  from build pack                                         15m29s      57s Succeeded
    Credential Initializer 96dnz                          15m29s       0s Succeeded
    Working Dir Initializer R2ngt                         15m28s       0s Succeeded
    Place Tools                                           15m27s       0s Succeeded
    Build Container Build                                 15m25s      17s Succeeded
    Build Make Linux                                      15m26s      10s Succeeded
    Git Merge                                             15m26s       4s Succeeded
    Git Source Dcanadillas Jx Go Http Pr 1 Ser V6bpx      15m26s       1s Succeeded https://github.com/dcanadillas/jx-go-http
    Postbuild Post Build                                  15m25s      18s Succeeded
    Promote Jx Preview                                    15m25s      53s Succeeded
    Promote Make Preview                                  15m25s      32s Succeeded
  Preview                                                 14m33s           https://github.com/dcanadillas/jx-go-http/pull/1
    Preview Application                                   14m33s           http://jx-go-http.jx-dcanadillas-jx-go-http-pr-1.35.189.194.245.nip.io
```

You can check the preview environment by:

```bash
jx get previews
```

Output (do not copy)

```
PULL REQUEST                                     NAMESPACE                      APPLICATION
https://github.com/dcanadillas/jx-go-http/pull/1 jx-dcanadillas-jx-go-http-pr-1 http://jx-go-http.jx-dcanadillas-jx-go-http-pr-1.35.189.194.245.nip.io
```

So, you can check the application preview environment by going to the previous URL in the output of ‘jx get previews’. There you should see your changes in Development to be merged into Master and then to be able to deploy a new version into Staging:

![Preview of Staging](images/GHPreviewPR.png)

In this lab we didn’t configure a different GitHub user to act as “a bot” so you cannot approve your own PR with the `/approve` command of Prow. So, in this case we will close the PR manually to trigger the promotion pipeline into Staging:

![Merging manually the PR](images/GHMergePR.png)

> **Note:**
> 
> During the installation process you could have configured a different GitHub user for the “Pipeline Server”. This user then act as a “bot” to generate the comments automatically in the Pull Request to work with Prow.
> 
> Then, you could approve a pull request just by commenting “/approve” in the PR messages if you are one of the approvers defined in the repo `OWNERS` file.
> ![Approve Prow command in GitHub](https://raw.githubusercontent.com/dcanadillas/jenkins-x-lab/master/images/ApproveProw.png)

This should trigger the promotion pipeline into Staging. Let’s check the execution:

```bash
jx get activity -f jx-go-http -w
```

Output (do not copy)

```
dcanadillas/jx-go-http/master #2                           1m25s          Running Version: 0.0.2
  from build pack                                          1m25s          Running
    Credential Initializer Slgsg                           1m25s       0s Succeeded
    Working Dir Initializer B878d                          1m24s       0s Succeeded
    Place Tools                                            1m23s       0s Succeeded
    Build Container Build                                  1m22s      17s Succeeded
    Build Make Build                                       1m22s       9s Succeeded
    Build Post Build                                       1m21s      17s Succeeded
    Git Merge                                              1m22s       2s Succeeded
    Git Source Dcanadillas Jx Go Http Master R Tlsmg       1m22s       1s Succeeded https://github.com/dcanadillas/jx-go-http
    Promote Changelog                                      1m21s      23s Succeeded
    Promote Helm Release                                   1m21s      27s Succeeded
    Promote Jx Promote                                     1m21s          Running
    Setup Jx Git Credentials                               1m22s       2s Succeeded
  Promote: staging                                           45s      44s Succeeded
    PullRequest                                              45s      44s Succeeded  PullRequest: https://github.com/dcanadillas-kube/environment-jenkins-x-lab-staging/pull/2 Merge SHA: bfff9a3be0eef8d845256979d9aa89702e31afb4
    Update                                                    1s       0s Succeeded
    Promoted                                                  1s       0s Succeeded  Application is at: http://jx-go-http.jx-staging.35.189.194.245.nip.io
```

Once we check in the previous output that the Pull Request #2 is succeeded, we can see our new version deployed:

```bash
jx get version
```

Output (do not copy)

```
APPLICATION STAGING PODS URL
jx-go-http  0.0.2   1/1  http://jx-go-http.jx-staging.35.189.194.245.nip.io
```

Let’s check the application deployed into staging by:

```bash
jx open jx-go-http -e staging
```

If we open the output url shown from the previous output in a browser tab the new version 0.0.2 of the application with the changes is shown.

Now you can go to the [next section](./JXPromotion.md):

<!-- [![Setup your environment](https://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/open?git_repo=https://github.com/dcanadillas/jenkins-x-lab&tutorial=labs/JXPromotion.md) -->