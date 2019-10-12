#!/usr/bin/env bash

ARCH=$(uname -m)
SYSTEM=$(uname -s | tr "[A-Z]" "[a-z]")
SOURCE_DIR=/source
DIST_DIR=/dist
VERSION=1.17.1
TAG="v${VERSION}"
GIT_REPO="https://github.com/numpy/numpy.git"

# Install dependencies
pip3 install /dist/Cython-0.29.13-cp36-cp36m-linux_aarch64.whl
#pip3 install -U setuptools

# Get numpy source
git clone "${GIT_REPO}" "${SOURCE_DIR}"
cd "${SOURCE_DIR}"
git checkout "${TAG}"

# Build wheel
python3 setup.py bdist_wheel

# Copy wheel to dist dir
cp ./dist/*.whl "${DIST_DIR}"
