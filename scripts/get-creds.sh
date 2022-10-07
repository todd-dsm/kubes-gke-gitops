#!/usr/bin/env bash
# shellcheck disable=SC2154,SC1091
# ------------------------------------------------------------------------------
#  PURPOSE:       *** FOR USE WHEN YOU DIDN'T BUILD THE CLUSTER ***
#           Load all kubeconfigs for the current environment from running:
#           source scripts/setup/build.env stage
#           Override with options and arguments for additional or
#           non-current environments.
# ------------------------------------------------------------------------------
#  PREREQS: a) The clusters need to be up, running and available to you.
#           b) source-in your environment variables.
#           c) run: 'make reset' before running this script.
#           d)
# ------------------------------------------------------------------------------
#  EXECUTE: scripts/get-creds.sh -v --env foo -z bar --project baz
# ------------------------------------------------------------------------------
#     TODO: 1) FIXME: case 'Unknown option' is not triggering
#           2) only works for zones now
#           3) make region/zone mutually exclusive
# ------------------------------------------------------------------------------
#   AUTHOR: Todd E Thomas
# ------------------------------------------------------------------------------
#  CREATED: 2018/10/00
# ------------------------------------------------------------------------------
#set -x


###-----------------------------------------------------------------------------
### VARIABLES
###-----------------------------------------------------------------------------
: "${TF_VAR_envBuild?  No environment defined}"
: "${TF_VAR_project_id?   No project defined}"
: "${TF_VAR_region?    No region defined}"
#: "${TF_VAR_zone?      No zone defined}"

# ENV Stuff
verbose=0
targetCluster="$TF_VAR_cluster_name"


###-----------------------------------------------------------------------------
### FUNCTIONS
###-----------------------------------------------------------------------------
function pMsg() {
    theMessage="$1"
    printf '%s\n' "$theMessage"
}

function pMsgS() {
    theMessage="$1"
    printf '\n%s\n' "$theMessage"
}

show_help()   {
    printf '\n%s\n\n' """
    Description: $0
    Run this program with no arguments to use defaults, sourced-in from:
    source scripts/setup/build.env myENV. OR, run this program WITH arguments
    to override those values for those of another cluster.

    Usage: $0 [OPTION1] [OPTION2]...

    OPTIONS:
    -e, --env       Which environment are we loading? stage, prod?
                      Example: $0 -e targetEnv

    -z, --zone      Tell me about the zone; do NOT use with regional clusters.
                      Example: $0 -z targetZone

    -r, --region    Tell me about the region; do NOT use with zonal clusters.
                      Example: $0 -v --region targetRegion

    -p, --project   Which project are we interested in?
                      Example: $0 --verbose --project targetProject

    -v, --verbose   Turn on 'set -x' debug output.
    """
    exit 0
}

print_error_noval() {
    printf 'ERROR: "--file" requires a non-empty option argument.\n' >&2
    exit 1
}

# confirm the argument value is non-zero and
test_opts() {
    myVar=$1
    if [[ -n "$myVar" ]]; then
        export retVal="$myVar"
        echo "$myVar"
    else
        print_error_noval
    fi
}

###---
### Select the new cluster
###---
function activateCluster() {
    source "${HOME}/.ktx"
    source "$HOME/.ktx-completion.sh"
    ktx "${targetCluster}.ktx"
    kubectl config get-contexts
}

# rename cloud-defaults, they're way too long
function renameCreds() {
    bsName="$1"
    niceName="$2"
    pMsg "Changing that obnoxious name..."
    kubectl config rename-context "$bsName" "$niceName"
    kubectl config get-contexts
}

# grab the kubeconfig for the current cluster
function getKubeConfig() {
    myRegion=$1
    myCluster=$2
    gcloud container clusters get-credentials "$myCluster" --region="$myRegion"
    activateCluster
}


###-----------------------------------------------------------------------------
### MAIN PROGRAM
###-----------------------------------------------------------------------------
### Parse Arguments
###---
if [[ -z "$2" ]]; then
    :
else
    while :; do
        case "$1" in
            -h|-\?|--help) # Call "show_help" function; display and exit.
                show_help
                exit 0
                ;;
            -e | --env)
                export TF_VAR_envBuild="$2"
                echo "$TF_VAR_envBuild"
                shift
                ;;
            -z | --zone)
                export TF_VAR_zone="$2"
                echo "$TF_VAR_zone"
                shift
                ;;
            -r | --region)
                export TF_VAR_region="$2"
                echo "$TF_VAR_region"
                shift
                ;;
            -p | --project)
                export TF_VAR_project="$2"
                echo "$TF_VAR_project"
                shift
                break
                ;;
            -v|--verbose)
                verbose=$((verbose + 1))
                ;;
            --) # End of all options.
                shift
                break
                ;;
            -?*)
                printf '\n%s\n' '  WARN: Unknown option (ignored):' "$1" >&2
                printf '\n%s\n\n' "  Run: '$0 --help me' for more info."
                exit
                ;;
            *)  # Default case: If no more options then break out of the loop.
                printf '\n%s\n\n' "  Run: $0 --help for more info."
                pMsg "Please review this help information and try again."
                show_help
                break
        esac
        shift
    done
fi


###----------------------------------------------------------------------------
### Turn on debugging output if requested
###----------------------------------------------------------------------------
if [[ "$verbose" -eq '1' ]]; then
    set -x
fi


###---
### Last-minute help check
###---
if [[ "$1" == '-h' ]] || [[ "$1" == '--help' ]]; then
    show_help
fi


###----------------------------------------------------------------------------
### MAIN PROGRAM
###----------------------------------------------------------------------------
### Echo an array element keyed from an environment variable
###---
sleep 5s
set -x
pMsg "Pulling the kubeconfig for:"
while IFS=$'\n' read -r foundCluster; do
    # Is this cluster already configured?
    [[ $foundCluster != "$targetCluster" ]] && continue
    export foundCluster="$foundCluster"
    if [[ -e "$ktxFile" ]]; then
        echo "Updating the KUBECONFIG definition..."
        rm -f "$ktxFile"
        export USE_GKE_GCLOUD_AUTH_PLUGIN=True
        getKubeConfig "$TF_VAR_region" "$foundCluster"
    else
        getKubeConfig "$TF_VAR_region" "$foundCluster"
    fi
    # Change those obnoxious names
    renameCreds "gke_${TF_VAR_project_id}_${TF_VAR_region}_${foundCluster}" \
        "$foundCluster"
done < <(gcloud container clusters list \
    --region="$TF_VAR_region" --format 'value(NAME)')

set -x

###---
### Display the cluster-info
###---
if ! kubectl cluster-info; then
    pMsg "Something is wrong with the kube-api."
fi


###---
### fin~
###---
exit 0
