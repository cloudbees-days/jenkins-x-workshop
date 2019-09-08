# Install the Jenkins X CLI binary

There is a script included in this repo to install Jenkins X CLI depending on your platform (Linux or MacOS) and the Jenkins X distribution (CloudBees or OSS). For this lab we are using Jenkins OSS, so just execute the following to install CLI version 2.0.643:

```bash
./install-jx.sh -v 2.0.643
```

Output (do not copy)

```
Installing Jenkins X OSS version 2.0.643.

You are installing Jenkins X in: 

ProductName:    Mac OS X
ProductVersion: 10.14.6
BuildVersion:   18G87
Downloading and installing binary...

  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   613    0   613    0     0   1532      0 --:--:-- --:--:-- --:--:--  1536
  0 62.9M    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0x LICENSE
x README.md
x changelog.md
100 62.9M  100 62.9M    0     0  13.6M      0  0:00:04  0:00:04 --:--:-- 17.1M

WARNING: Failed to find helm installs: running helm list --all --namespace cbcore: failed to run 'helm list --all --namespace cbcore' command in directory '', output: 'Error: could not find a ready tiller pod'
WARNING: Failed to get helm version: failed to run 'helm version --short' command in directory '', output: 'Client: v2.13.1+g618447c
Error: could not find a ready tiller pod'
NAME               VERSION
jx                 2.0.643
Kubernetes cluster v1.12.7-gke.25
kubectl            v1.14.1
git                2.21.0
Operating System   Mac OS X 10.14.6 build 18G87

        Jenkins X cli is already installed in "/usr/local/bin/jx"

Activating the Jenkins X Profile
```

If you want to work with the CloudBees Jenkins X Distribution, you can do it by:

```bash
./install-jx -c
```

You can find also the [manual steps to install Jenkins X CLI](https://jenkins-x.io/getting-started/install/) in Jenkins X documentation

Now you can go to the [next section](./JXCreateCluster.md):

<!-- [![Setup your environment](https://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/open?git_repo=https://github.com/dcanadillas/jenkins-x-lab&tutorial=labs/JXInstall.md) -->