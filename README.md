# oacapture-appimage-build
Dockerfile and scripts to build oaCapture under Ubuntu 14.04 and create an AppImage

# Introduction
This repository provides the means to build an oaCapture AppImage.

 - oaCapture: Astro imaging application, mainly targetted at Linux. For further information see [oaCapture](http://www.openastroproject.org/oacapture/)
 - AppImage: Application package format that allows running an Application on all major Linux distribution without actually installing it. It does so, by packaging the binary and all needed dependencies (shared libraries, additonal data files) in a single ISO filesystem image. This image contains an ELF header as its bootblock, which loopback mounts the image and starts the application inside. See [AppImage](http://appimage.org/) for more information.

# Building
See README.txt in the Ubuntu14 subfolder.

It describes using Docker to create an Ubuntu 14.04 instance to build oaCapture and create an AppImage. If you happen to run Ubuntu 14.04 or have a VM setup, you can also run the build_[1-3]_*.sh scripts directly.

In order to run the generated AppImage on as many distributions as possible, it is beneficial to build it on the oldest system possible.
