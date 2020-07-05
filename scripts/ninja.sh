#!/usr/bin/env bash

ARCH=$(uname -m)
SYSTEM=$(uname -s | tr "[A-Z]" "[a-z]")
SOURCE_DIR=/source
DIST_DIR=/dist
VERSION=1.10.0
TAG="${VERSION}"
GIT_REPO="https://github.com/scikit-build/ninja-python-distributions.git"

# Install dependencies
pip3 install scikit-build

# Get numpy source
git clone "${GIT_REPO}" "${SOURCE_DIR}"
cd "${SOURCE_DIR}"
git checkout "${TAG}"

# Build wheel
python3 setup.py bdist_wheel

# Copy wheel to dist dir
cp ./dist/*.whl "${DIST_DIR}"
