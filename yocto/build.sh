#!/bin/bash

if [ ${#} -ne 3 ]; then
  echo "Missing argument"
fi

branch=${1}
machine=${2}
target=${3}

cd ${branch}
source oe-init-build-env build-${machine}
bitbake ${target}

