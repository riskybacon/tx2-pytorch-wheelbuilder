# tx2-pytorch-wheelbuilder

Building PyTorch for the Jetson TX2 on the Jetson TX2 is a long process.

And there's quite a few moving parts. I started this project because I wanted
to install Nvidia's Apex library with pyprof enabled, and to get that support,
I needed to compile from source. As I dug into the rebuild, I found quite a few
dependencies and wanted to make things easier on myself for future builds.

This repo contains scripts to build whl files for each package that
supports a PyTorch build.

Install nvidia-docker on host before starting, if needed

Create the wheelbuilder docker image

```
pushd wheelbuilder
./build.sh
popd
```

Create wheels:

From top level of repo dir

```
export DIST=$(pwd)/dist
export BUILD=$(pwd)/../build
export SCRIPTS=$(pwd)/scripts
mkdir ${DIST}
mkdir ${BUILD}

for pkg in cython ninja numpy pillow pytorch torchvision ; do
    nvidia-docker run --rm -v${DIST}:/dist -v${BUILD}:/build -v${SCRIPTS}:/scripts:ro wheelbuilder:latest ./scripts/${pkg}.sh
done
```
