#!/usr/bin/env bash
# shellcheck disable=SC2155
#  PURPOSE: This script sends the demo apps to the cluster with a specific tag.
# -----------------------------------------------------------------------------
#  PREREQS: a) the git client must be installed
#           b) ssh keys for your user must be configured in GitHub
#           c)
# -----------------------------------------------------------------------------
#  EXECUTE: addons/ingress/istio/istio-demo.sh
# -----------------------------------------------------------------------------
#   AUTHOR: Todd E Thomas (github.com/todd-dsm)
# -----------------------------------------------------------------------------
#set -x


###----------------------------------------------------------------------------
### VARIABLES
###----------------------------------------------------------------------------
# ENV Stuff
appRepo='https://raw.githubusercontent.com/istio/istio'
appVersion='1.15.0'
appManifest='samples/bookinfo/platform/kube/bookinfo.yaml'
netManifest='samples/bookinfo/networking/bookinfo-gateway.yaml'
ruleManifest='samples/bookinfo/networking/destination-rule-all.yaml'
demoDeployment="${appRepo}/${appVersion}/${appManifest}"
istioGW="${appRepo}/release-${appVersion%.*}/${netManifest}"
istioDestRule="${appRepo}/release-${appVersion%.*}/${ruleManifest}"

#set -x
#echo "$istioDestRule"
#echo 'https://raw.githubusercontent.com/istio/istio/release-1.15/samples/bookinfo/networking/destination-rule-all.yaml'
#exit
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
### Push the Bookinfo App to the cluster
###---
pMsg "Sending the demo app out to the cluster..."
kubectl apply -f "$demoDeployment"


###---
### Define the ingress gateway for the application
### REF: https://raw.githubusercontent.com/istio/istio/release-1.15/samples/bookinfo/networking/bookinfo-gateway.yaml
###---
pMsg "Sending the Istio Gateway to the cluster..."
kubectl apply -f "$istioGW"

### Wait for it


###---
### Collect some data
###---
export INGRESS_HOST="$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')"
export INGRESS_PORT="$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')"
export SECURE_INGRESS_PORT="$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')"
export TCP_INGRESS_PORT="$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="tcp")].port}')"

#pMsg "Load Balancer IP: $INGRESS_HOST"
#pMsg "HPPT Port:        $INGRESS_PORT"
#pMsg "HTTPS Port:       $SECURE_INGRESS_PORT"
#pMsg "TCP Ingress Port: $TCP_INGRESS_PORT"

#export GATEWAY_URL="$INGRESS_HOST:$INGRESS_PORT"
export GATEWAY_Addr="http://$INGRESS_HOST:$INGRESS_PORT/productpage"
pMsg "$GATEWAY_Addr"


###---
### Create default destination rules for the Bookinfo services
###   We can later build versioning into the service with 'Destination Rules'
###   REF: https://istio.io/latest/docs/concepts/traffic-management/#destination-rules
###---
pMsg "Sending the Istio Gateway to the cluster..."
kubectl apply -f "$istioDestRule"


###---
### The Wrap
###---
sleep 5s

pMsg """
This experiment can now be used to sample Istio’s other features for
traffic routing, fault injection, rate limiting, etc.
"""


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
