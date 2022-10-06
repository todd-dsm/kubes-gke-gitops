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
### Dump Kiali - IF it's installed
###---
if kubectl -n istio-system get kialis.kiali.io > /dev/null 2>&1; then
    kubectl -n istio-system delete -f "$kialiUIConfig"
    helm uninstall --namespace kiali-operator kiali-operator
else
    pMsg "Kiali is not installed; moving on..."
fi

exit

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
### Clean up the local cruft
###---
rm -rf .terraform/ "$filePlan" "$ktxFile"


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
### REQ
###---


###---
### fin~
###---
exit 0
