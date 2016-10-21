#!/bin/sh

set -e # Halt on error
set -x # Be verbose

#
# Build oaCapture.AppImage
#

APP=oaCapture
VERSION=1.0.0
APPIMAGE=$APP-$VERSION.AppImage
rm -f $APPIMAGE
rm -rf ./$APP.AppDir
mkdir -p ./$APP.AppDir
cd ./$APP.AppDir

OACAPTURE_BUILD_DIR=../oacapture-1.0.0
APPIMAGE=oaCapture-1.0.0.AppImage

cp ../AppImageKit/AppRun .
chmod a+x AppRun

cp $OACAPTURE_BUILD_DIR/osx/oaCapture.iconset/icon_32x32.png oaCapture.png

cat >oacapture.desktop << EOH
[Desktop Entry]
Name=oaCapture
Exec=oacapture
Icon=oaCapture.png
EOH

# Copy all referenced libraries
mkdir -p ./usr/lib
ldd /usr/local/bin/oacapture | grep -v linux-vdso |\
  grep "=>" | awk '{print $3}' | xargs -I '{}' cp -v '{}' ./usr/lib || true

# Workaround for
# relocation error: /mnt/usr/lib/libc.so.6: symbol _dl_starting_up
rm usr/lib/libc.so.6

# Further workarounds (see also https://github.com/probonopd/AppImages/blob/master/excludelist)
rm usr/lib/libm.so.6
rm usr/lib/libstdc++.so.6
rm usr/lib/libpthread.so.0
rm usr/lib/libdl.so.2

# Copy main binary
mkdir -p ./usr/bin
cp /usr/local/bin/oacapture ./usr/bin
cp /sbin/fxload ./usr/bin
strip ./usr/bin/*

# Copy ext libraries
mkdir -p ./usr/local/lib
cp $OACAPTURE_BUILD_DIR/ext/libaltaircam/libaltaircam.so ./usr/local/lib
cp $OACAPTURE_BUILD_DIR/ext/libtoupcam/libtoupcam.so ./usr/local/lib
cp -a $OACAPTURE_BUILD_DIR/lib/firmware ./usr/local/lib

# Patch /usr to ././
cd usr/ ; find . -type f -exec sed -i -e 's|/usr/lib|././/lib|g' {} \; ; cd ..
cd usr/ ; find . -type f -exec sed -i -e 's|/usr/local/lib|././/local/lib|g' {} \; ; cd ..

# AppDir finally set up. Exit dir
cd ..

# Build AppImage
./AppImageKit/AppImageAssistant.AppDir/package ./$APP.AppDir/ $APPIMAGE


