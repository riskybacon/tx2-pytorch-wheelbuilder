#!/usr/bin/env bash

ARCH=$(uname -m)
SYSTEM=$(uname -s | tr "[A-Z]" "[a-z]")
SOURCE_DIR=/source
DIST_DIR=/dist
VERSION=1.4.1
TAG="v${VERSION}"
GIT_REPO="https://github.com/pytorch/pytorch.git"

# Install dependencies
pip3 install /dist/Cython-0.29.20-cp36-cp36m-linux_aarch64.whl
pip3 install /dist/numpy-1.19.0-cp36-cp36m-linux_aarch64.whl
pip3 install /dist/ninja-1.10.0-cp36-cp36m-linux_aarch64.whl
pip3 install scikit-build

# Get source code
git clone --recursive "${GIT_REPO}" "${SOURCE_DIR}"
cd "${SOURCE_DIR}"
git checkout "${TAG}"

export USE_NCCL=0
export USE_DISTRIBUTED=1
export TORCH_CUDA_ARCH_LIST="5.3;6.2;7.2"

#pip3 install -U setuptools
pip3 install -r requirements.txt

python3 setup.py bdist_wheel

cp ./dist/*.whl "${DIST_DIR}"
