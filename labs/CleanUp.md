# Cleaning Up

If you want to leave your GitHub as it is was before doing this lab, you just need to delete the repos jx created for you here:

```bash
jx delete repo \
-n environment-jenkins-x-lab-production \
-n environment-jenkins-x-lab-staging \
-n jx-go-http
```

When prompted, answer the following questions:

* Git user name **<your_github_username>**
* Are you sure you want to delete these all these repositories? **Y**

Output (do not copy)

```sh
WARNING: You are about to delete these repositories 'environment-jenkins-x-lab-production,environment-jenkins-x-lab-staging' on the Git provider. This operation CANNOT be undone!
? Are you sure you want to delete these all these repositories? Yes
Deleted repository <your_username>/environment-jenkins-x-lab-production
Deleted repository <your_username>/environment-jenkins-x-lab-staging
```
