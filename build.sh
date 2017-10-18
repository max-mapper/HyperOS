#!/bin/sh

# install missing dependencies
which unsquashfs > /dev/null
if [ "$?" != 0 ]; then
  printf 'Installing missing dependency: unsquashfs'
  if [ "$(uname)" = "Darwin" ]; then
    brew install squashfs
  elif [ "$(uname)" = "Linux" ]; then
    apt-get install squashfs-tools
  fi
  [ "$?" = 0 ] || { printf 'Could not install unsquashfs' && exit 1; }
fi

which nugget > /dev/null
if [ "$?" != 0 ]; then
  printf 'Installing missing dependency: nugget'
  npm install -g nugget
  [ "$?" = 0 ] || { printf 'Could not install nugget' && exit 1; }
fi

# exit on any error
set -e

mkdir -p dist

# install packages
for f in tczs/*.tcz; do echo "Unpacking $f" && unsquashfs -f -d dist $f; done

# enter dist folder
cd dist

# extract rootfs
zcat < ../corepure64.gz | sudo cpio -i -d

# enables terminal (i think, blindly copied from xhyve example)
sudo sed -ix "/^# ttyS0$/s#^..##" etc/securetty
sudo sed -ix "/^tty1:/s#tty1#ttyS0#g" etc/inittab

# configure ssh server
sudo cp ../sshd_config usr/local/etc/ssh/sshd_config
sudo mkdir var/ssh
sudo chmod 0755 var/ssh
sudo mkdir var/lib/sshd
sudo chmod 0755 var/lib/sshd
sudo mkdir -p home/tc/.ssh

# leave dist
cd ../

# copy our files in
sudo rsync --recursive include/ dist

# repackage core into final output
(cd dist ; sudo find . | sudo cpio -o -H newc) | gzip -c > initrd.gz

# cleanup
sudo rm -rf dist

echo "done"
