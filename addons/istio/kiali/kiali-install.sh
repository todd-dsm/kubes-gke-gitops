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
### Send the Kiali Operator to the cluster
###---
helm install \
    --set cr.create=true \
    --set cr.namespace=istio-system \
    --namespace kiali-operator \
    --create-namespace \
    kiali-operator \
    kiali/kiali-operator


###---
### Tell the Operator to deploy the Kiali UI
### REF: https://kiali.io/docs/installation/installation-guide/creating-updating-kiali-cr
###---
kubectl -n istio-system create -f "$kialiUIConfig"


###---
### Validate the Install
###---
bash <(curl -sL https://raw.githubusercontent.com/kiali/kiali-operator/master/crd-docs/bin/validate-kiali-cr.sh) \
  -crd https://raw.githubusercontent.com/kiali/kiali-operator/master/crd-docs/crd/kiali.io_kialis.yaml \
  --kiali-cr-name kiali \
  -n istio-system


###---
### Get status
###---
kubectl get kiali kiali -n istio-system -o jsonpath='{.status.conditions[].type}'


###---
### Get the Token
###---
kubectl get secret -n istio-system \
    "$(kubectl get sa kiali-service-account -n istio-system -o \
    "jsonpath={.secrets[0].name}")" \
        -o jsonpath='{.data.token}' | base64 -d > "$kialiToken"


###---
### Get the Token
###---


###---
### Get the Token
###---


###---
### fin~
###---
exit 0
