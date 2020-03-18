#!/bin/bash
set -euo pipefail
release=ci
ns=ci
kubectl create namespace ci || true
pushd ../crds
helm install $release-crds . -n $ns
popd
helm install $release . -n $ns
