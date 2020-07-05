#!/usr/bin/env bash

# l4t-base is missing cudnn files needed to build cupy with cudnn support
cp /usr/include/cudnn.h ./cudnn
cp /usr/lib/aarch64-linux-gnu/libcudnn_static.a ./cudnn/

export WB_VERSION=0.2
docker build -t wheelbuilder .
tag=$(docker images | grep wheelbuilder | grep latest | awk '{print $3}')
docker tag ${tag} wheelbuilder:${WB_VERSION}
