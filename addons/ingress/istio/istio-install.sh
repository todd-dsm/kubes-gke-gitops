#!/usr/bin/env bash
# shellcheck disable=SC1091,SC2154
#  PURPOSE: Installs the Demo version of Istio: v1.15 at present.
# -----------------------------------------------------------------------------
#  PREREQS: a) get the package: brew install istioctl
#           b)
#           c)
# -----------------------------------------------------------------------------
#  EXECUTE:
# -----------------------------------------------------------------------------
#     TODO: 1)
#           2)
#           3)
# -----------------------------------------------------------------------------
#   AUTHOR: Todd E Thomas (github.com/todd-dsm)
# -----------------------------------------------------------------------------
#set -x


###----------------------------------------------------------------------------
### VARIABLES
###----------------------------------------------------------------------------
# ENV Stuff
#: "${1?  Wheres my first agument, bro!}"
#myNamespace='gitlab-managed-apps'
#myReleaseName="${myRepoName}-ui"
#myValues='addons/gitlab/ingress/values.yaml'
#newValues='https://raw.githubusercontent.com/antonputra/tutorials/6526fd7536cbc8ce4327e2526e3d96cdd4e87418/lessons/082/values.yaml'
#myVersion='3.35.0'


### Use KTX to select tthe cluster
source "${HOME}/.ktx"
source "${HOME}/.ktx-completion.sh"

# Data

###----------------------------------------------------------------------------
### FUNCTIONS
###----------------------------------------------------------------------------
function pMsg() {
    theMessage="$1"
    printf '%s\n' "$theMessage"
}


###----------------------------------------------------------------------------
### MAIN PROGRAM
###----------------------------------------------------------------------------
### Ensure some baselines for the install
###---
ktx "${ktxFile##*/}"


###---
### REQ
###---
kubectl config set-context --current --namespace=default


###---
### Install Istio:latest
###---
istioctl install --set profile=demo -y


###---
### Add a namespace label to instruct Istio to automatically inject
### Envoy sidecar proxies when you deploy your application later
###---
pMsg "Labeling the namespace..."
kubectl label namespace default istio-injection=enabled


###---
### Verify the installation
###---
pMsg "Verifying the installation..."
istioctl verify-install


###---
### Validate the current configuration on the 'default' namespace
###---
istioctl analyze


###---
### Wait for the LB to come online
###---
kubectl --namespace istio-system get service istio-ingressgateway


###---
### REQ
###---


###---
### REQ
###---


###---
### fin~
###---
exit 0
