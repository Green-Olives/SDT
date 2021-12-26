#!/bin/bash

function startDeleting() {
    kubectl apply -f manifests/frontend_deployment.yaml
    kubectl apply -f manifests/backend_deployment.yaml
    kubectl apply -f manifests/postgresql_deployment.yaml
    kubectl apply -f manifests/persistent_volume.yaml
    kubectl apply -f manifests/secret.yaml
    kubectl apply -f manifests/config.yaml
    removeLabel "$1"
}

function removeLabel() {
    kubectl label nodes "$1" sdt-
}

function getLastNode() {
    return "$(kubectl get nodes | tr '\n' '|' | sed -r 's/.*\|([^ ]*) .*/\1/g')"
}

volumeMachine=getLastNode

if [[ -n $1 ]]
then volumeMachine="$1"
fi

startDeleting "$volumeMachine"