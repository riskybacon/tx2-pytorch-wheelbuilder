#!/usr/bin/env bash

SOURCE_DIR=/source
DIST_DIR=/dist

TAG="6.2.2"
GIT_REPO="https://github.com/python-pillow/Pillow.git"

# Install dependencies
apt-get update && apt-get install -y zlib1g-dev libjpeg-dev
pip3 install /dist/Cython-0.29.20-cp36-cp36m-linux_aarch64.whl

# Get source code
git clone --recursive "${GIT_REPO}" "${SOURCE_DIR}"
cd "${SOURCE_DIR}"
git checkout "${TAG}"

# Build the software
python3 setup.py bdist_wheel

# Copy it to the host
cp ./dist/*.whl "${DIST_DIR}"
