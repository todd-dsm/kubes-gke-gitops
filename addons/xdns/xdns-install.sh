#!/usr/bin/env bash
# shellcheck disable=SC1091,SC2154
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
set -x


###----------------------------------------------------------------------------
### VARIABLES
###----------------------------------------------------------------------------
# ENV Stuff
#: "${TF_VAR_cluster_name?    Whats the cluster name, bro!}"
targetVersion='6.10.2'

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
### Source-in the variables
###---
#source build.env "$TF_VAR_envBuild" > /dev/null 2>&1


###---
### Create the Manifest from a Template
###---
#pMsg "Creating the Deployment from a Template..."
#envsubst < "$valuesTmpl" > "$valuesFile"


###----------------------------------------------------------------------------
### Preconditions: create a service account for ExternalDNS: now in Terraform
###----------------------------------------------------------------------------

###----------------------------------------------------------------------------
### Install ExternalDNS
###----------------------------------------------------------------------------
pMsg "Sending external-dns to the cluster..."
#helm upgrade --install external-dns external-dns/external-dns \
#    --values="$valuesFile"

helm upgrade --install external-dns bitnami/external-dns \
    --version="$targetVersion" --set provider='google' \
    --set google.project="$myProject" --set google.zoneVisibility='public' \
    --set google.serviceAccountSecret="$xdnsSA" --set domainFilters="{$dns_name}" \
    --set google.erviceAccountSecretKey="$TF_VAR_xdns_key" \
    --set logLevel='debug' #--set policy=sync





###---
### Record post-conditions
###---
pMsg "Recording post-conditions:"
kubectl get deployment external-dns


###---
### REQ
###---


###---
### REQ
###---


###---
### REQ
###---


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
