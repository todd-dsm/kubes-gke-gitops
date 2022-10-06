#!/usr/bin/env bash
# shellcheck disable=SC2154
#  PURPOSE: After it's all installed/configured, display the useful bits to the
#           operator.
# -----------------------------------------------------------------------------
#     DOCS:
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
#   AUTHOR: Todd E Thomas (github.com/todd-dsm)
# -----------------------------------------------------------------------------
#set -x


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
###
###---

###---
### Kiali: Port-forward out to the Web UI
###   * Call the portforward script when there's time
###---
pMsg "Portforwarding out to the Kiali UI..."
kubectl port-forward svc/kiali 20001:20001 -n istio-system&
open -a 'Google Chrome' 'http://localhost:20001'
#if ! scripts/portforward-to-pod.sh 'kiali' 20001 'istio-system'; then
#    pMsg "  Couldn't open the port; check on that."
#fi


###---
### Dump the initial login token on the admin's system
###---
pMsg "Pulling the Kiali login token... $kialiToken"
cat /dev/null > "$kialiToken"
kubectl get secret -n istio-system \
    "$(kubectl get sa kiali-service-account -n istio-system \
    -o 'jsonpath={.secrets[0].name}')" -o jsonpath='{.data.token}' | \
    base64 -d > "$kialiToken"

cat "$kialiToken"


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
### REQ
###---


###---
### REQ
###---
set +x


###---
### Display Kiali Token
###---
cat "$kialiToken"

###---
### fin~
###---
exit 0
