# What is XMR-Stak?

XMR-Stak is a universal Stratum pool miner. This miner supports CPUs, AMD and NVIDIA gpus and can be used to mine the crypto currency Monero and Aeon.
## Links

- [Source Code](https://github.com/fireice-uk/xmr-stak)

# How to use this image

## Configuration file

Create `config.txt` configuration file and adapt to your need before running.
You can copy file from a container:

```console
$ docker run -d --name some-xmr-stak-config csaber67/iox_monero_miner
$ docker cp some-xmr-stak-config:/usr/local/etc/config.txt .
$ docker stop some-xmr-stak-config
$ docker rm some-xmr-stak-config
```
## Running

Run in background:

```console
$ docker run -itd --name some-xmr-stak-cpu -v "$PWD"/config.txt:/usr/local/etc/config.txt csaber67/iox_monero_miner
```

Use `--privileged` option for large pages support. Large pages need a properly set up OS.

Fetch logs of a container:

```console
$ docker logs some-xmr-stak
```

Attach:

```console
$ docker attach some-xmr-stak
```

# Image Variants

The images come in two flavors, with and without donation fee.

## `xmr-stak:<version>`

This is the defacto image. By default the miner will donate 1% of the hashpower (1 minute in 100 minutes) to dev's pool.

## `xmr-stak-cpu:nodevfee`

This variant has no donation fee.

# Donations

Donations for work on dockerizing are accepted at:

- XMR: `47vHbK7gXWfWgaDuvpwGZzCratKixPtYhYmtLHA2QZv3HFFVVNbExunVNJh3CeT8Xa22MiMbjBRj83grCmTS6wyo4EaSSv4`
