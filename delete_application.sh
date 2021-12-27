#!/bin/bash

function startDeleting() {
    kubectl delete -f manifests/frontend_deployment.yaml
    kubectl delete -f manifests/backend_deployment.yaml
    kubectl delete -f manifests/postgresql_deployment.yaml
    kubectl delete -f manifests/persistent_volume.yaml
    kubectl delete -f manifests/secret.yaml
    kubectl delete -f manifests/config.yaml
    removeLabel "$1"
}

function removeLabel() {
    kubectl label nodes "$1" sdt-
}

function getLastNode() {
    volumeMachine="$(kubectl get nodes | tr '\n' '|' | sed -r 's/.*\|([^ ]*) .*/\1/g')"
}

getLastNode

if [[ -n $1 ]]
then volumeMachine="$1"
fi

startDeleting "$volumeMachine"