# uphold/geth
An Ethereum Go client/full-node implementation docker image.

[![uphold/geth][docker-pulls-image]][docker-hub-url] [![uphold/geth][docker-stars-image]][docker-hub-url] [![uphold/geth][docker-size-image]][docker-hub-url] [![uphold/geth][docker-layers-image]][docker-hub-url]

## Supported tags
- `1.4.5`, `latest` ([Dockerfile](/Dockerfile))

## What is geth?
[Geth](https://github.com/ethereum/go-ethereum/wiki/geth) is the command line interface for running a full Ethereum node implemented in Go. It is the main deliverable of the [Frontier Release](https://github.com/ethereum/go-ethereum/wiki/Frontier).

## Usage
### How to use this image
This image contains the main binary from the Geth project - `geth`. It behaves like a binary, so you can pass any arguments to the image and they will be forwarded to the `geth` binary:

```sh
$ docker run --rm uphold/geth --dev --rpc
```

By default, `geth` will run as user `ethereum` for security reasons and with its default data dir (`~/.geth`). If you'd like to customize where `geth` stores its data, you must use the `GETH_DATA` environment variable. The directory will be automatically created with the correct permissions for the `ethereum` user and `geth` automatically configured to use it.

```sh
$ docker run -e GETH_DATA=/var/lib/geth --rm uphold/geth --dev --rpc
```

You can also mount a directory in a volume under `/home/ethereum/.geth` in case you want to access it on the host:

```sh
$ docker run -v ${PWD}/data:/home/ethereum/.geth --rm uphold/geth --dev --rpc
```

You can optionally create a service using `docker-compose`:

```yml
geth:
  image: uphold/geth
  command:
    --dev
    --rpc
    --rpcapi "eth,web3"
```

## Supported Docker versions
This image is officially supported on Docker version 1.10, with support for older versions provided on a best-effort basis.

## License
The [uphold/geth](https://hub.docker.com/r/uphold/geth) docker project is under MIT license.

[docker-hub-url]: https://hub.docker.com/r/uphold/geth
[docker-layers-image]: https://img.shields.io/imagelayers/layers/uphold/geth/latest.svg?style=flat-square
[docker-pulls-image]: https://img.shields.io/docker/pulls/uphold/geth.svg?style=flat-square
[docker-size-image]: https://img.shields.io/imagelayers/image-size/uphold/geth/latest.svg?style=flat-square
[docker-stars-image]: https://img.shields.io/docker/stars/uphold/geth.svg?style=flat-square
