#!/usr/bin/env bash

ARCH=$(uname -m)
SYSTEM=$(uname -s | tr "[A-Z]" "[a-z]")
SOURCE_DIR=/source
DIST_DIR=/dist
CUPY_REPO="https://github.com/cupy/cupy.git"
CUPY_VERSION="8.0.0b4"
CUPY_TAG="v${CUPY_VERSION}"
CUB_REPO="https://github.com/NVlabs/cub.git"

NUM_CPUS=$(lscpu | grep "^CPU(" | awk '{print $NF}')

# Install dependencies
pip3 install /dist/Cython-0.29.20-cp36-cp36m-linux_aarch64.whl

# Get cupy source
git clone "${CUPY_REPO}" "${SOURCE_DIR}/cupy"
cd "${SOURCE_DIR}/cupy"
git submodule update --init
ln -s "${SOURCE_DIR}/cupy/cupy/core/include/cupy/cub/cub" /usr/include/aarch64-linux-gnu/
git checkout "${CUPY_TAG}"

# The following is needed to avoid this error:
# cupy/cuda/cupy_cub.cu:1:10: fatal error: cupy/complex.cuh: No such file or directory
ln -s ${SOURCE_DIR}/cupy/cupy/core/include/cupy /usr/include/aarch64-linux-gnu/

# Build wheel
python3 setup.py build -j ${NUM_CPUS} bdist_wheel

# Copy wheel to dist dir
cp ./dist/*.whl "${DIST_DIR}"
