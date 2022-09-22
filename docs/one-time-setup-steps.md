# One Time Setup Steps

## Required Programs

1. `gcloud` - `brew install google-cloud-sdk`
   1. Then install the [kubectl authentication plugin]
   2. `gcloud components install gke-gcloud-auth-plugin`
2. We'll need an Ingress at some point; Istio is a good one
   1. `brew install istioctl`
3. Terraform - `brew install tfenv`
   1. [tfenv use]
   2. [tfenv repo]
4. Install Vault
   1. `brew tap hashicorp/tap`
   2. `brew install hashicorp/tap/vault`
5. Install the real version of Bash; the one that comes with macOS is forever old
   1. `brew install bash shellcheck`
   2. scripts _**will break**_ if this step is skipped

## Set up shop

1 - Pull the code: https://github.com/todd-dsm/kubes-gke-gitops

2 - Edit `build.env` and fill-in your own variable assignments; source them in:

`source build.env stage`

This will pull in all the staging variables.

3 - Set up your auth, however you do that

* I started with `gcloud auth application-default login` and followed [that path]; auth is up to you.

4 - Create a project bucket for Terraform state

`scripts/setup/bucket-project-create.sh`

5 - Enable services `(enable|disable)`

`scripts/services.sh enable`

If all that goes well, you're ready to start terraforming :sunglasses:

[kubectl authentication plugin]:https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
[tfenv use]:https://gist.github.com/todd-dsm/1dc120506e89ec36d4d9a05ccb93f68c
[tfenv repo]:https://github.com/tfutils/tfenv
[that path]:https://cloud.google.com/docs/authentication/provide-credentials-adc
