# HyperOS

A 50MB linux distribution that has [dat-container](https://github.com/mafintosh/dat-container), a utility that can live boot containers using `dat` and `systemd-nspawn` remotely over the secure p2p encrypted dat network.

The goal of HyperOS is to provide the most minimal possible linux host environment that can be used to remote mount dat containers. It is intended to be run on Mac OS and/or Windows as a minimal host Linux. The idea is you only have to download a 50MB OS, boot it, and then you can use dat-container to boot your actual container (e.g. an Ubuntu based 1GB or more container) much more efficiently, as dat-container supports "live-boot".

You can install it easily using the `npm install linux -g` module on npm.

## build it

Download Buildroot on a linux machine. Rename `buildroot-config` to `buildroot/.config` and rename `linux-config` to whatever file `make linux-menuconfig` edits (I think it's a `.config` file in `buildroot/output/` somewhere).

The linux config enables `virtio-net` drivers in the linux kernel, which are disabled in Buildroot by default. You can also use `make menuconfig` to modify packages etc that are installed in the root filesystem. Currently `systemd` is the main requirement so that we can use `systemd-nspawn`. We also include openssh, fuse and a couple other utilities needed by dat-container.

Then place those two files in this repository and run the build script `./build.sh`. Then you can copy the resulting `initrd.gz` into `maxogden/linux` to boot it.

## how it works

When building the container, the `rootfs.cpio` is extracted to a temporary folder called `dist/`. The `include/` folder in this directory is merged on top of the HyperOS filesystem. Currently the only thing we do with this is set the `motd` and install a startup service called `set-ssh-auth-key`. When booting the container, you can pass in a SSH public key and a hostname as the kernel CMDLINE, which becomes available in linux after boot as `/proc/cmdline`. The `set-ssh-auth-key` service parses this file and sets the container hostname and installs the SSH key in `/root/.ssh/authorize_keys`.

The container should attempt to acquire a DHCP lease on boot, so to know when the container is fully booted and online you can (on Mac OS) watch `/etc/dhcpd_leases` for the IP address that matches the hostname you passed into the container. You can then use this IP to ssh into the container. This functionality is implemented in the `npm install linux -g` module.
