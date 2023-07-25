---
title: Getting Started
weight: -15
---

This page tells you how to get started with the Webmesh project.

{{< toc >}}

## Install Webmesh Node Binary

The `node` binary is distributed as a container image or a standalone binary.
To install the binary, download the latest release for your platform and architecture from the [releases page](https://github.com/webmeshproj/node/releases).
To run the container image, pull the latest image from the GitHub container registry.
The examples in this guide will use the image.

## Configuration

Configuration can be supplied via a configuration file, environment variables, or command line flags.
You can choose to use any combination of these methods.
To see all available configuration options, run `node --help`.

When using a configuration file, the file can be in TOML, YAML, or JSON format.
It is first interpreted as a go-template with the following additional functions:

- `env` - returns the value of the environment variable with the given name.
- `file` - returns the contents of the file with the given name.

After templating is complete, the file is parsed as the given format.

## Bootstrap a New Network

If you'd like to play with the project on Kubernetes, there is a work-in-progress controller in the [operator](https://github.com/webmeshproj/operator/) repository.
It works fine on most clusters, including ephemeral docker-based ones, but is not yet ready for production use.

A simple bootstrap node may be started with the following command:

```bash
# You can remove the --global.no-ipv6 flag if you have IPv6 connectivity on your docker network.
docker run --rm --privileged --name=bootstrap-node ghcr.io/webmeshproj/node:latest \
    --global.insecure \
    --global.no-ipv6 \
    --global.detect-endpoints \
    --global.detect-private-endpoints \
    --bootstrap.enabled
```

All that is required above is the `--bootstrap.enabled` flag.
The others are optional, but useful for testing purposes.
The `--global.insecure` flag disables authentication and authorization. This is not recommended for production use.

Raft data by default is stored in the `/var/lib/webmesh/store` directory.
This can be changed by setting the `--raft.data-dir` flag.
You can also choose to run a node completely in-memory by setting the `--raft.in-memory` flag.

By default the following ports are used for communication between nodes:

| Port  | Protocol | Description |
| ----- | -------- | ----------- |
| 8443  | gRPC     | API         |
| 9443  | TCP      | Raft        |
| 51820 | UDP      | WireGuard   |

These are configurable via the `--services.listen-address`, `--raft.listen-address`, and `--wireguard.listen-port` flags respectively.

## Join a Network

You can connect another container to the network by running the following command:

```bash
docker run --rm --privileged ghcr.io/webmeshproj/node:latest \
    --global.insecure \
    --global.no-ipv6 \
    --mesh.join-address=bootstrap-node:8443
```

Depending on your docker network configuration, you may need to use the IP address of the bootstrap node instead of its hostname.

The `wmctl` utility distributed with the `node` binary can also be used to connect and/or query the APIs.
To start a WireGuard connection to the network:

```bash
wmctl connect --insecure --no-ipv6 --join-server=<container_ip>:8443
```
