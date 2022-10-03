#!/usr/bin/env bash
#  PURPOSE: Create a ConfigMap for SRE access to the cluster. By default, only
#           the cluster creator can access the new cluster. The ConfigMap is a
#           definition of 'who' should be able to access it; typically a group.
# -----------------------------------------------------------------------------
#  PREREQS: a)
#           b)
#           c)
# -----------------------------------------------------------------------------
#  EXECUTE:
# -----------------------------------------------------------------------------
#     TODO: 1)
#           2)
#           3)
# -----------------------------------------------------------------------------
#   AUTHOR: Todd E Thomas
# -----------------------------------------------------------------------------
#  CREATED: 2020/12/05
# -----------------------------------------------------------------------------
#set -x


###----------------------------------------------------------------------------
### VARIABLES
###----------------------------------------------------------------------------
# ENV Stuff
: "${TF_VAR_cluster_apps?    Whats the cluster name, bro!}"
#valuesTmpl='addons/xdns/values.tmpl'
#valuesFile='/tmp/values.yaml'
valuesFile='/tmp/values.yaml'


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
### Create the Manifest from a Template
###---
#pMsg "Creating the Deployment from a Template..."
#envsubst < "$valuesTmpl" > "$valuesFile"


###---
### Validate; the Manifest should always match the Target
### The Target shouldnt change much
###---
#pMsg "Validating there is no drift in the ConfigMap"
#pMsg "  Diff output regarding the eksctl-pipes-dev-nodegroup-* are okay."
#if ! diff "$deploymentTarget" "$valuesFile"; then
#    pMsg "  The ConfigMap Manifest does not match the Target."
#    exit 1
#fi


###---
### Add SREs to the cluster
###---
pMsg "Sending it to the cluster..."
helm upgrade --install external-dns external-dns/external-dns \
    --values="$valuesFile"


###---
### Record post-conditions
###---
pMsg "Recording post-conditions:"
kubectl get deployment external-dns


###---
### REQ
###---


###---
### fin~
###---
exit 0
