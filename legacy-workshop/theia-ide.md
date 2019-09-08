# Using the Theia IDE
DevPods have a `--sync` feature that will automatically sync local changes up to the DevPod. That is any changes you make locally will be pushed up to the DevPod, built automatically, and then a temporary version of your application will be deployed to the Jenkins X cluster.

Instead of using `--sync` we will be using another cool features of DevPods - [an embedded web based IDE called Theia](https://www.theia-ide.org/).

Open the Theia IDE in your browser.

Make a change to the code.

Commit to a new branch.

Go to GitHub and create a PR to the master branch.

Next section - [Preview Environments](./preview-environments.md)