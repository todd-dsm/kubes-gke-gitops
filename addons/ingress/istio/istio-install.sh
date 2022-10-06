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
instProfile='demo'

# Data

###----------------------------------------------------------------------------
### FUNCTIONS
###----------------------------------------------------------------------------
function pMsg() {
    theMessage="$1"
    printf '\n%s\n' "$theMessage"
}


###----------------------------------------------------------------------------
### MAIN PROGRAM
###----------------------------------------------------------------------------
### Ensure some baselines for the install
###---
pMsg "Setting the context: default"
kubectl config set-context --current --namespace=default


###---
### Add a namespace label to instruct Istio to automatically inject
### Envoy sidecar proxies when you deploy your application later
###---
pMsg "Labeling the namespace..."
kubectl label namespace default istio-injection=enabled

### Verify injection is enabled on the namespace
kubectl -n default get namespace default -o 'jsonpath={.metadata.labels}'


###---
### Install Istio:latest
###---
pMsg "Installing Istio with the $instProfile..."
istioctl install --set profile="$instProfile" -y


###---
### Install Istio:latest
###---
pMsg "Setting Istio's default log-level to debug during rollout..."
istioctl admin log --level default:debug
istioctl admin log | grep -E '(debug)$'
kubectl -n istio-system logs -l app=istiod


###---
### Verify the installation
###---
pMsg "Verifying the installation..."
istioctl verify-install


###---
### Validate the current configuration on the 'default' namespace
###---
pMsg "Analyzing the installation..."
istioctl analyze


###---
### Wait for the LB to come online
###---
pMsg "Verifying that we have an Load Balancer..."
sleep 3s
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
