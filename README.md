
# docker-ledger-sdk

[![Build Status](https://travis-ci.com/lukechilds/docker-ledger-sdk.svg?branch=master)](https://travis-ci.com/lukechilds/docker-ledger-sdk)
[![Docker Pulls](https://img.shields.io/docker/pulls/lukechilds/ledger-sdk.svg)](https://hub.docker.com/r/lukechilds/ledger-sdk/)

> Build a Ledger app with one command

A fully pre-configured Ledger SDK build environment.

<p align="center">
	<img src="demo.svg" width="720">
</p>

## Usage

To run `make` in your `~/code/my-ledger-app` project dir:

```
docker run -v ~/code/my-ledger-app:/code cryptoxic/ledger-sdk
```

If you're already in your project dir you can just do:

```
docker run -v ${PWD}:/code cryptoxic/ledger-sdk
```

To run an arbitrary command in your project dir:

```
docker run -v ${PWD}:/code cryptoxic/ledger-sdk 'make clean'
```

## License

MIT © Luke Childs

## Acknowledgements

This repo was forked from lukechilds' github and updated by me. I will try to keep the SDK, Clang and GCC up to date as much as I can.
