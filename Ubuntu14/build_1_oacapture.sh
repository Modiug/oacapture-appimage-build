#!/bin/sh

set -e # Halt on error
set -x # Be verbose

#
# Fetch and build oaCapture
#

# Install needed packages for building oaCapture
apt-get install -y \
    libqt4-dev libv4l-0 libv4lconvert0 fxload libcfitsio3-dev libtiff-dev libudev-dev \
    libraw1394-dev libusb-dev libSDL-dev

# Fetch oaCapture itself

if [ ! -f oacapture-1.0.0.tar.bz2 ]; then
    wget http://www.openastroproject.org/wp-content/uploads/2016/06/oacapture-1.0.0.tar.bz2
fi

rm -rf oacapture-1.0.0
tar jxf oacapture-1.0.0.tar.bz2

cd oacapture-1.0.0
(cd ext/libdc1394/; autoreconf -vfi) # Currently needed
./configure
make
make install
cd ..
