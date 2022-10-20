#!/usr/bin/env bash
# shellcheck disable=SC2154
#  PURPOSE: Description
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
set -x


###----------------------------------------------------------------------------
### VARIABLES
###----------------------------------------------------------------------------
# ENV Stuff
#: "${1?  Wheres my first agument, bro!}"

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
### REQ
###---


###---
### kill all kubectl port forwarding
###---
pMsg "Dumping all port forwarding PIDs..."
while read -r myPID; do
    kill -9 "$myPID"
done < <(pgrep kubectl)


###---
### Dump ExternalDNS
###---
if kubectl get pod -l app.kubernetes.io/name=external-dns > /dev/null 2>&1; then
    pMsg "ExternalDNS is not installed; moving on..."
else
    helm uninstall --namespace default external-dns
fi


###---
### Dump Kiali - IF it's installed
###---
if kubectl -n istio-system get kialis.kiali.io > /dev/null 2>&1; then
    kubectl -n istio-system delete -f "$kialiUIConfig"
    helm uninstall --namespace kiali-operator kiali-operator
else
    pMsg "Kiali is not installed; moving on..."
fi


###---
### Dump Istio - IF it's installed
###---
pMsg "Uninstalling (purge) Istio..."
if istioctl profile list > /dev/null 2>&1; then
    istioctl uninstall --purge -y
fi


###---
### Destroy the Infrastructure
###---
terraform apply -destroy -auto-approve -no-color 2>&1 | \
    tee "/tmp/tf-${TF_VAR_project}-destroy.out"


###---
### FIXME: something his lingering, keeping the network from beging destroyed.
###        wait for a few more seconds and try again
###---
sleep 30s
tf destroy -target module.network.module.subnets.google_compute_subnetwork.subnetwork -auto-approve
tf destroy -target module.network.module.vpc.google_compute_network.network -auto-approve


###---
### Clean up the local cruft
###---
rm -rf "$filePlan" "$ktxFile" #.terraform/


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
### REQ
###---


###---
### fin~
###---
exit 0
