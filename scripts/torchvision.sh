#!/usr/bin/env bash

ARCH=$(uname -m)
SYSTEM=$(uname -s | tr "[A-Z]" "[a-z]")
SOURCE_DIR=/source
DIST_DIR=/dist
VERSION=0.4.0
TAG="v${VERSION}"
GIT_REPO="https://github.com/pytorch/vision.git"

# Install dependencies
apt-get update && apt-get install -y zlib1g-dev libjpeg-dev
pip3 install /dist/Cython-0.29.20-cp36-cp36m-linux_aarch64.whl
pip3 install /dist/numpy-1.19.0-cp36-cp36m-linux_aarch64.whl
pip3 install /dist/torch-1.2.0a0+8554416-cp36-cp36m-linux_aarch64.whl
pip3 install /dist/Pillow-6.2.2-cp36-cp36m-linux_aarch64.whl

# Get source code
git clone --recursive "${GIT_REPO}" "${SOURCE_DIR}"
cd "${SOURCE_DIR}"
git checkout "${TAG}"

# Build the software
python3 setup.py bdist_wheel

# Copy it to the host
cp ./dist/*.whl "${DIST_DIR}"
