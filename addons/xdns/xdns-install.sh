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
: "${TF_VAR_cluster_apps?    Whats the cluster name, bro!}"
export xdnsSA="${xdnsSA}@$myProject.iam.gserviceaccount.com"
export mySAKey="/tmp/${xdnsSA%%@*}-key.json"

#valuesTmpl='addons/xdns/values.tmpl'
#valuesFile='/tmp/values.yaml'


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
### Preconditions: create a service account for ExternalDNS
###----------------------------------------------------------------------------
# Securing the service
# REF: https://github.com/dewitt/knative-docs/blob/master/serving/using-external-dns.md

# 1. Terraform the GKE cluster without Cloud DNS scope: check
# 2. Create a new service account for Cloud DNS admin role.

gcloud iam service-accounts create "${xdnsSA%%@*}" \
    --description="Service Account for ExternalDNS cross-project access" \
    --display-name="ExternalDNS Admin"


# 3. Bind the role 'dns.admin' to the newly created service account.
# Fully-qualified service account name also has project-id information.
gcloud projects add-iam-policy-binding "$myProject" \
    --member "serviceAccount:$xdnsSA" \
    --role roles/dns.admin


# 4. Download the secret key file for your service account
gcloud iam service-accounts keys create "$mySAKey" \
    --iam-account="$xdnsSA"

### SWITCH TO THE STAGING CLUSTER: experimental
# 5. Upload the PROD service account credential to your STAGE cluster.
# for now, we'll create 2 keys: 1=stage and 1=prod
kubectl create secret generic "${xdnsSA%%@*}" \
    --from-file="${mySAKey##*/}=$mySAKey"

### Verify service account key
kubectl get secret "${xdnsSA%%@*}"

exit

###----------------------------------------------------------------------------
### Validate; the Manifest should always match the Target
### The Target shouldnt change much
###----------------------------------------------------------------------------
#pMsg "Validating there is no drift in the ConfigMap"
#pMsg "  Diff output regarding the eksctl-pipes-dev-nodegroup-* are okay."
#if ! diff "$deploymentTarget" "$valuesFile"; then
#    pMsg "  The ConfigMap Manifest does not match the Target."
#    exit 1
#fi


###---
### Install ExternalDNS
###---
pMsg "Sending it to the cluster..."
#helm upgrade --install external-dns external-dns/external-dns \
#    --values="$valuesFile"

helm upgrade --install external-dns external-dns/external-dns \
    --set provider='google' --set google.project="$myProject" \
    --set namespace='default' \
    --set google.zoneVisibility='public'

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
