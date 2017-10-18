#!/bin/sh
# prerequisites: wget
export TCL_SERVER=http://tinycorelinux.net/8.x/x86_64

# download rootfs + kernel
wget -c $TCL_SERVER/release/distribution_files/{corepure64.gz,vmlinuz64}

# download packages
wget -c -P tczs/ \
  $TCL_SERVER/tcz/fuse.tcz \
  # $TCL_SERVER/tcz/gcc.tcz \
  # $TCL_SERVER/tcz/gcc_base-dev.tcz \
  # $TCL_SERVER/tcz/gcc_libs-dev.tcz \
  # $TCL_SERVER/tcz/gcc_libs.tcz \
  # $TCL_SERVER/tcz/glibc_base-dev.tcz \
  $TCL_SERVER/tcz/iproute2.tcz \
  # $TCL_SERVER/tcz/linux-4.8.1_api_headers.tcz \
  # $TCL_SERVER/tcz/make.tcz \
  $TCL_SERVER/tcz/openssh.tcz \
  $TCL_SERVER/tcz/openssl.tcz \
  $TCL_SERVER/tcz/pkg-config.tcz
  # $TCL_SERVER/tcz/util-linux.tcz \
  # $TCL_SERVER/tcz/pciutils.tcz \
  # $TCL_SERVER/tcz/libpci.tcz \
  # $TCL_SERVER/tcz/ncurses.tcz \
  # $TCL_SERVER/tcz/readline.tcz \
  # $TCL_SERVER/tcz/libvirt.tcz
