#!/usr/bin/env bash

ARCH=$(uname -m)
SYSTEM=$(uname -s | tr "[A-Z]" "[a-z]")
SOURCE_DIR=/build/pytorch
DIST_DIR=/dist
VERSION=1.5.1
TAG="v${VERSION}"
GIT_REPO="https://github.com/pytorch/pytorch.git"

# Install dependencies
apt-get install -y libopenblas-dev
pip3 install /dist/Cython-0.29.20-cp36-cp36m-linux_aarch64.whl
pip3 install /dist/numpy-1.19.0-cp36-cp36m-linux_aarch64.whl
pip3 install /dist/ninja-1.10.0-cp36-cp36m-linux_aarch64.whl
pip3 install scikit-build

# Get source code
if [ ! -d "${SOURCE_DIR}" ] ; then
    mkdir "${SOURCE_DIR}"
fi

if [ ! -d "${SOURCE_DIR}/.git" ] ; then
    git clone --recursive "${GIT_REPO}" "${SOURCE_DIR}"
fi

cd "${SOURCE_DIR}"
git checkout "${TAG}"
git submodule sync
git submodule update --init --recursive

export USE_NCCL=0
export USE_DISTRIBUTED=1
export TORCH_CUDA_ARCH_LIST="5.3;6.2;7.2"
export USE_FBGEMM=OFF

#pip3 install -U setuptools
pip3 install -r requirements.txt

python3 setup.py bdist_wheel

cp ./dist/*.whl "${DIST_DIR}"
