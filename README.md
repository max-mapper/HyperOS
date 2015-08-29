# hypercore

builds a distribution of [tinycore linux](http://tinycorelinux.net/) that includes [hyperfused](https://github.com/mafintosh/hyperfused) our remote fs mounting daemon

## build it

Note: only builds on Linux

```
apt-get install squashfs-tools
npm i nugget -g
build.sh
````

It should create `vmlinuz` (kernel) and `hypercore.gz` (filesystem)

## build dev environment

```
./build-dev.sh
```

It should create `vmlinuz` (kernel) and `hypercore-dev.gz` (filesystem)
