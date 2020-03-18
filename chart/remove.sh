#!/bin/bash
set -euo pipefail
release=ci
ns=ci
helm delete $release -n $ns || true
helm delete $release-crds -n $ns || true
kubectl delete namespace $ns || true
kubectl delete crd \
    backends.app.foldy.dev \
    foldyservices.app.foldy.dev \
    ingressroutes.traefik.containo.us \
    ingressroutetcps.traefik.containo.us \
    middlewares.traefik.containo.us \
    tlsoptions.traefik.containo.us \
    traefikservices.traefik.containo.us || true
