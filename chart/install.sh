#!/bin/bash
set -eu

###########################################################
## Cert Manager for SSL certificate automation
###########################################################
if [ -z "$(kubectl get namespace | grep cert-manager)" ]; then
    echo "Installing cert-manager..."
    kubectl apply --validate=false \
        -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.14/deploy/manifests/00-crds.yaml
    kubectl create namespace cert-manager
    kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.14.0/cert-manager.yaml
    while [ -z $(kubectl rollout status -n cert-manager deploy/cert-manager | grep 'successfully rolled out') ]; do
        sleep 3s
        echo "Waiting for cert-manager..."
    done
    echo "cert-manager is now deployed!"
fi

###########################################################
## Extra resources for ingress
###########################################################
kubectl create namespace argocd
kubectl apply -f extra/
sleep 5s

###########################################################
## Argo CD for continuous deployment
###########################################################
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

###########################################################
## Foldy
###########################################################
release=ci
ns=ci
kubectl create namespace ci || true

# Update CRDs
pushd ..
rm -rf crds/templates
mkdir crds/templates
cp foldy-operator/deploy/crds/*_crd.yaml crds/templates
popd

# Install CRDs
pushd ../crds
helm install $release-crds . -n $ns
popd

# Install foldy
helm install $release . -n $ns

