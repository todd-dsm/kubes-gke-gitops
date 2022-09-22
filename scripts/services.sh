#!/usr/bin/env bash
#  PURPOSE: A client runs this script to assign base permissions to SMPL Cloud
#           Support users.
# -----------------------------------------------------------------------------
#  PREREQS: a) Client must have permissions to assign roles to users.
#           b) Client must have gcloud sdk installed
#           c)
# -----------------------------------------------------------------------------
#  EXECUTE:     ./scripts/services.sh <enable|disable>
# -----------------------------------------------------------------------------
#     TODO: 1)
#           2)
#           3)
# -----------------------------------------------------------------------------
#   AUTHOR: Todd E Thomas
# -----------------------------------------------------------------------------
#  CREATED: 2020/05/23
# -----------------------------------------------------------------------------
set -x

# Pre-game check
if [[ "${BASH_VERSINFO:-0}" -lt 4 ]]; then
    echo "This script requires GNU Bash v4 to support arrays; please upgrade."
    exit 1
fi

###----------------------------------------------------------------------------
### VARIABLES
###----------------------------------------------------------------------------
# ENV Stuff
# REF: https://cloud.google.com/sdk/gcloud/reference/services/list
#declare projAPIs=('cloudresourcemanager' 'cloudbilling' 'iam' 'compute' \
#    'container' 'containerregistry' 'dns' 'storage-component' 'cloudtrace')
userAction=$1
declare projAPIs=('dns' 'compute' 'container')

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
### Enable the APIs
### Any action taken by Terraform requires requisite APIs are enabled.
###---
set +x
printf '\n\n%s\n' "Enabling required APIs..."
for adminAPI in "${projAPIs[@]}"; do
    gcloud services "$userAction" "${adminAPI}.googleapis.com"
    pMsg "  * $adminAPI"
done


###---
### REQ
###---


###---
### fin~
###---
exit 0
