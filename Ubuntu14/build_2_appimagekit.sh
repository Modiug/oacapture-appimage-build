#!/bin/sh

set -e # Halt on error
set -x # Be verbose

#
# Fetch and build AppImageKit
#

# Needed packages
apt-get -y install libfuse-dev libglib2.0-dev cmake libc6-dev binutils realpath fuse

# Fetch and build AppImageKit
rm -rf AppImageKit
git clone https://github.com/probonopd/AppImageKit.git
cd AppImageKit
cmake .
make
cd ..

