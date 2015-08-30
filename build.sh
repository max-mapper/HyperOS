# create a tinycorelinux fs with custom .tcz packages
# prerequisites: linux, apt-get install squashfs-tools, npm i nugget -g

export TCL_SERVER=http://tinycorelinux.net/6.x/x86_64

mkdir -p downloads dist

# dl release + packages (add your packages here)
nugget -c -d downloads \
  $TCL_SERVER/release/distribution_files/corepure64.gz \
  $TCL_SERVER/tcz/fuse.tcz \
  https://github.com/mafintosh/hyperfused/releases/download/0.0.0/hyperfused.tcz

# install packages
unsquashfs -f -d dist downloads/fuse.tcz
unsquashfs -f -d dist downloads/hyperfused.tcz

# extract rootfs
cd dist
zcat ../downloads/corepure64.gz | sudo cpio -f -i -H newc -d --no-absolute-filenames

# enables terminal (i think, blindly copied from xhyve example)
sudo sed -i '/^# ttyS0$/s#^..##' etc/securetty
sudo sed -i '/^tty1:/s#tty1#ttyS0#g' etc/inittab

cd ../

# copy our files in
sudo rsync --recursive include/ dist

# repackage core into output.gz
(cd dist ; find | sudo cpio -o -H newc) | gzip -c > hypercore.gz

# cleanup
sudo rm -rf dist

# now boot vmlinuz64 and output.gz like this https://github.com/mist64/xhyve/blob/cd782515fff03bd4b80da60e29108f6b33476bf5/xhyverun.sh