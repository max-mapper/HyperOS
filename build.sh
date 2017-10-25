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

# copy our files in
sudo rsync -l --recursive include/ dist

# repackage core into final output
(cd dist ; sudo find . | sudo cpio -o -H newc) | gzip -c > initrd.gz

# cleanup
sudo rm -rf dist

echo "done"
