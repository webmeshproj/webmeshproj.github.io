---
title: Getting Started
weight: -15
---

This page tells you how to get started with the Webmesh project.

{{< toc >}}

## Install Webmesh Node Binary

The `webmesh-node` binary is distributed as a container image or a standalone binary.
To install the binary, refer to the [installation instructions](/documentation/installation-instructions/) for your platform.
To run the container image, pull the latest image from the GitHub container registry.
The examples in this guide will use the image.

## (Optional) Install Webmesh GUI Application

There is a GUI application provided that exposes a limited set of functionality.
Installers can be found under releases in the [webmesh-app](https://github.com/webmeshproj/webmesh-app/releases) repository.

## Configuration

Configuration can be supplied via a configuration file, environment variables, or command line flags.
You can choose to use any combination of these methods.
To see all available configuration options, run `webmesh-node --help`.
A detailed description of each option is available in the [configuration reference](/documentation/configuration/).

When using a configuration file, the file can be in TOML, YAML, or JSON format.

## Bootstrap a New Network

A simple bootstrap node may be started with the following command:

```bash
# You can remove the --global.disable-ipv6 flag if you have IPv6 connectivity on your docker network.
# The simple docker-compose example in the readme shows how to do this.
docker run --rm --privileged --name=bootstrap-node ghcr.io/webmeshproj/node:latest \
    --global.insecure \
    --global.disable-ipv6 \
    --global.detect-endpoints \
    --global.detect-private-endpoints \
    --bootstrap.enabled
```

All that is required above is the `--bootstrap.enabled` flag.
The others are optional, but useful for testing purposes.
The `--global.insecure` flag disables authentication and authorization. This is not recommended for production use.
Several authentication methods are available, but the easiest to setup is mTLS.
You can find instructions for setting up mTLS [here](/documentation/using-mtls/).

Raft data by default is stored in the `/var/lib/webmesh/store` directory.
This can be changed by setting the `--raft.data-dir` flag.
You can also choose to run a node completely in-memory by setting the `--raft.in-memory` flag.

By default the following ports are used for communication between nodes:

| Port  | Protocol | Description |
| ----- | -------- | ----------- |
| 8443  | gRPC     | API         |
| 9000  | TCP      | Raft        |
| 51820 | UDP      | WireGuard   |

These are configurable via the `--services.api.listen-address`, `--raft.listen-address`, and `--wireguard.listen-port` flags respectively.

## Join a Network

After the bootstrap node is running we can start the regular node.
Most docker configurations will automatically create a DNS alias for you on the docker network.
For the sake of completeness and avoiding confusion we'll lookup the IP address of the bootstrap node.

```bash
$ docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' bootstrap-node
192.168.254.2
```

You can connect another container to the network by running the following command:

```bash
docker run --rm --privileged ghcr.io/webmeshproj/node:latest \
    --global.insecure \
    --global.disable-ipv6 \
    --mesh.join-addresses=192.168.254.2:8443
```

The same arguments can be used to join a node running outside of docker or via the GUI application.

Depending on your docker network configuration, you may need to use the IP address of the bootstrap node instead of its hostname.

## Next Steps

Now that you have a network running, you can look through the various configuration docs to learn how to configure and use it.
More documentation will be added in the future.
