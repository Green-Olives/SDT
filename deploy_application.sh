#!/bin/bash

function startDeploying() {
    addLabel "$1"
    kubectl apply -f manifests/config.yaml
    kubectl apply -f manifests/secret.yaml
    kubectl apply -f manifests/persistent_volume.yaml
    kubectl apply -f manifests/postgresql_deployment.yaml
    kubectl apply -f manifests/backend_deployment.yaml
    #kubectl apply -f manifests/frontend_deployment.yaml
}

function addLabel() {
    kubectl label nodes "$1" sdt=volume
}

function getLastNode() {
    return "$(kubectl get nodes | tr '\n' '|' | sed -r 's/.*\|([^ ]*) .*/\1/g')"
}

volumeMachine=getLastNode

if [[ -n $1 ]]
then volumeMachine="$1"
fi

startDeploying "$volumeMachine"