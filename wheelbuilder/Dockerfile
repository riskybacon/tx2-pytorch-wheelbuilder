FROM nvcr.io/nvidia/l4t-base:r32.2

# Needed to add cudnn for cupy
COPY cudnn/cudnn.h /usr/include/aarch64-linux-gnu/cudnn.h
COPY cudnn/cudnn.h /usr/include/cudnn.h
COPY cudnn/libcudnn_static.a /usr/lib/aarch64-linux-gnu
RUN cd /usr/lib/aarch64-linux-gnu && ln -s libcudnn.so.7 libcudnn.so

RUN apt-get update && \
    apt-get install -y build-essential python3-dev python3-pip git cmake && \
    mkdir /scripts && \
    mkdir /dist && \
    mkdir /sources
