#!/usr/bin/env bash

SOURCE_DIR=/source
DIST_DIR=/dist

# Aug 29, 2019. I'd use a version tag, but this repo has no tags
TAG="53eae1986320d016ee7b347d78839dd5e96e7e93"
GIT_REPO="https://github.com/NVIDIA/apex.git"

# Install dependencies
pip3 install /dist/Cython-0.29.13-cp36-cp36m-linux_aarch64.whl
pip3 install /dist/numpy-1.17.1-cp36-cp36m-linux_aarch64.whl
pip3 install /dist/torch-1.2.0a0+8554416-cp36-cp36m-linux_aarch64.whl
pip3 install --upgrade pip

# Get source code
git clone "${GIT_REPO}" "${SOURCE_DIR}"
cd "${SOURCE_DIR}"
git checkout "${TAG}"

# Build the software
python3 setup.py -v --pyprof --cpp_ext --cuda_ext bdist_wheel

# Copy it to the host
cp ./dist/*.whl "${DIST_DIR}"
