#!/usr/bin/env bash
# shellcheck disable=SC1091,SC2154
#  PURPOSE: Installs the kiali-operator on the cluster; presently v1.56.1
# -----------------------------------------------------------------------------
#     DOCS: https://kiali.io/docs/installation/installation-guide/install-with-helm
# -----------------------------------------------------------------------------
#  PREREQS: a) helm and the chart repo
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
set -x


###----------------------------------------------------------------------------
### VARIABLES
###----------------------------------------------------------------------------
# ENV Stuff
#: "${1?  Wheres my first agument, bro!}"
myRepoName='kiali'
myRepoURL="https://kiali.org/helm-charts"
myNameSpace='kiali-operator'

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
### Install Kiali
### REF: https://kiali.io/docs/installation/installation-guide/install-with-helm/
###----------------------------------------------------------------------------
### Install/configure the helm repo if it's not already
###---
if ! helm repo  list | grep "$myRepoName"; then
    pMsg "configuring helm chart repo..."
    helm repo add "$myRepoName" "$myRepoURL"
    helm repo update
else
    echo "This chart repo is already configured"
fi


###---
### Send it to the cluster
###---
helm install \
    --set cr.create=true \
    --set cr.namespace=istio-system \
    --namespace "$myNameSpace" \
    --create-namespace "$myNameSpace" \
    kiali/kiali-operator


###---
### Wait for it...
###---
kubectl -n "$myNameSpace" wait --for=condition=Ready pods -l app="$myNameSpace"


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
