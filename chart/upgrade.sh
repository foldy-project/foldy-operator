#!/bin/bash
set -euo pipefail
release=ci
ns=ci
helm upgrade $release . -n $ns
