#!/bin/sh

# exit on any error
set -e

mkdir -p dist

# enter dist folder
cd dist

# extract rootfs
cat ../rootfs.cpio | sudo cpio -idmv

# leave dist
cd ../

# shrink dat-container
# rm -rf include/usr/lib/node_modules/dat-container/node_modules/esprima/test
# rm -rf ./usr/lib/node_modules/dat-container/node_modules/sodium-native/prebuilds/
# rm -rf ./usr/lib/node_modules/dat-container/node_modules/utp-native/prebuilds/

# copy our files in
sudo rsync -pl --recursive include/ dist

# sudo find . -name ‘*.DS_Store’ -type f -delete

# repackage core into final output
(cd dist ; sudo find . | sudo cpio -o -H newc) | gzip -c > initrd.gz

# cleanup
sudo rm -rf dist

echo "done"
