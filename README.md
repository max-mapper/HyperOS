# hypercore

A distribution of [tinycore linux](http://tinycorelinux.net/) that includes [hyperfused](https://github.com/mafintosh/hyperfused) our remote fs mounting daemon

The goal of HyperCore is to provide the most minimal possible linux host environment that can be used to remote mount data + containers for higher level workflows

HyperCore is part of http://hyperos.io/

## build it

```sh
./download.sh
./build.sh
````

## dependencies

The following dependencies will be installed:
- `unsquashfs` package to create an OS image
- `nugget` package to pull data over the wire

It should create `vmlinuz` (kernel) and `initrd.gz` (filesystem)

Prebuilt releases are available at https://github.com/maxogden/hypercore/releases
