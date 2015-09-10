# hypercore

A distribution of [tinycore linux](http://tinycorelinux.net/) that includes [hyperfused](https://github.com/mafintosh/hyperfused) our remote fs mounting daemon

The goal of HyperCore is to provide the most minimal possible linux host environment that can be used to remote mount data + containers for higher level workflows

HyperCore is part of http://hyperos.io/

## build it

```
apt-get install squashfs-tools # brew install squashfs on mac
npm i nugget -g  
./download.sh
./build.sh
````

It should create `vmlinuz` (kernel) and `initrd.gz` (filesystem)

Prebuilt releases are available at https://github.com/maxogden/hypercore/releases
