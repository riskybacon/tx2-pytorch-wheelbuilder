#!/usr/bin/env bash

ARCH=$(uname -m)
SYSTEM=$(uname -s | tr "[A-Z]" "[a-z]")
SOURCE_DIR=/source
DIST_DIR=/dist
VERSION=1.19.0
TAG="v${VERSION}"
GIT_REPO="https://github.com/numpy/numpy.git"
NUM_CPUS=$(lscpu | grep "^CPU(" | awk '{print $NF}')

# Install dependencies
apt-get install -y libopenblas-dev
pip3 install /dist/Cython-0.29.20-cp36-cp36m-linux_aarch64.whl
#pip3 install -U setuptools

# Get numpy source
git clone "${GIT_REPO}" "${SOURCE_DIR}"
cd "${SOURCE_DIR}"
git checkout "${TAG}"

# Build wheel
python3 setup.py build -j ${NUM_CPUS} bdist_wheel

# Copy wheel to dist dir
cp ./dist/*.whl "${DIST_DIR}"
