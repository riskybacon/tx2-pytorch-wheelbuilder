#!/usr/bin/env bash

ARCH=$(uname -m)
SYSTEM=$(uname -s | tr "[A-Z]" "[a-z]")
SOURCE_DIR=/source
DIST_DIR=/dist
VERSION=0.29.13
TAG="${VERSION}"
GIT_REPO="https://github.com/cython/cython.git"
WHEEL="Cython-${VERSION}-cp36-cp36m-${SYSTEM}_${ARCH}.whl"

apt-get update && apt-get install -y build-essential python3-dev python3-pip git
git clone "${GIT_REPO}" "${SOURCE_DIR}"
cd "${SOURCE_DIR}"
git checkout "${TAG}"
python3 setup.py install bdist_wheel
cp "./dist/${WHEEL}" "${DIST_DIR}"
