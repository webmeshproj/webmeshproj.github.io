---
title: Setup a Personal VPN
---

In this guide we'll set up a simple personal VPN using the [WireGuard](https://www.wireguard.com/) protocol.
For the purposes of this guide, we'll assume you're running a Linux distribution, but the steps should be similar for other operating systems.
Creating a Linux VM on a cloud provider is a good way to get started, but for simplicity we'll use a local Ubuntu Server VM as an example.

We'll start with preparing the server.

## Install the WireGuard tools

First, we'll install the WireGuard tools on our local machine.
If your kernel already contains support for WireGuard, you can skip this step.
You may want to do it anyway for the `wg` command-line tool, which can be useful for debugging.

```bash
sudo apt update
sudo apt install wireguard
```

If the kernel module was not already loaded, you can load it manually with:

```bash
sudo modprobe wireguard
```

You may also set `wireguard.modprobe` in your node configuration to `true` to have the node load the module automatically.
This will only work on Linux systems.

## Install the Webmesh utilities

In this example we are using an `amd64` machine, but you can find other architectures on the [releases page](https://github.com/webmeshproj/node/releases).
We'll install two executables.
The `webmesh` utility will be the main node binary.
We'll also install the `wmctl` utility to generate a PKI for communicating with the node.

```bash
# Download the node binary
curl -JLO https://github.com/webmeshproj/node/releases/latest/download/node_linux_amd64
# Download the wmctl binary
curl -JLO https://github.com/webmeshproj/node/releases/latest/download/wmctl_linux_amd64
# Download the checksum
curl -JLO https://github.com/webmeshproj/node/releases/latest/download/sha256sums.txt
# Verify the checksum
sha256sum -c sha256sums.txt --ignore-missing
# Make the binaries executable
chmod +x node_linux_amd64 wmctl_linux_amd64
# Move the binaries to a location in your PATH
sudo mv node_linux_amd64 /usr/local/bin/webmesh
sudo mv wmctl_linux_amd64 /usr/local/bin/wmctl
# Remove the downloaded files
rm -f sha256sums.txt
# Ensure the installation was successful
webmesh --version
wmctl version
```

## Generate a PKI

We are just creating two nodes. Ourselves, and the server.
So this will be a very simple PKI.
By default the CA is valid for 1 year and the admin certificate for 90 days.
You can change these values with the `--ca-expiry` and `--admin-expiry` flags.

```bash
wmctl pki init --pki-directory pki
```

Generate a server certificate:

```bash
wmctl pki issue --pki-directory pki --name server
```

Copy the server certificate to a dedicated directory. In this example we'll use `/etc/webmesh/tls`.

```bash
sudo mkdir -p /etc/webmesh/tls
sudo cp pki/nodes/server/* /etc/webmesh/tls/
```

We can generate another certificate for ourselves if we want, but we'll just use the admin certificate for now.
We can use the wmctl utility to generate a CLI configuration for it.

```bash
# Find the IP address of the server (note your interface name may be different)
SERVER_IP=$(ip addr show dev enp1s0 | grep -Po 'inet \K[\d.]+')
# Generate the configuration
wmctl pki gen-config --pki-directory pki --server $SERVER_IP:8443 --output admin.yaml
```

If you need to use a different port for gRPC, change the `--server` flag accordingly.
You'll also need to specify it when configuring the node.

Download the generated configuration to your local machine.

## Start the node

Now we can start the node on the server.
The other documentation relies heavily on `docker` and `docker-compose`, so we'll instead use the `webmesh` utility directly via `systemd`.

You may write a configuration file or use environment variables to configure the node.
For simplicity, we will inline command-line arguments in the service file.

```bash
sudo tee /etc/systemd/system/webmesh.service <<EOF
[Unit]
Description=Webmesh Node
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/webmesh \
    --global.detect-endpoints \
    --global.detect-private-endpoints \
    --global.mtls \
    --global.tls-cert-file=/etc/webmesh/tls/tls.crt \
    --global.tls-key-file=/etc/webmesh/tls/tls.key \
    --global.tls-ca-file=/etc/webmesh/tls/ca.crt \
    --bootstrap.enabled \
    --bootstrap.default-network-policy=accept
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```

These arguments are the same as in the [using mTLS](/documentation/using-mtls/) guide.
One special thing to note is that in most cases you will omit the `--global.detect-private-endpoints` flag.
In this guide, we are using a local VM that does not have a public IP address, so we need to enable this flag to allow the node to detect its private IP address.

Enable and start the service:

```bash
sudo systemctl enable --now webmesh
```

You can check the status of the node with:

```bash
sudo systemctl status webmesh
```

Tail the logs with `journalctl`:

```bash
sudo journalctl -fu webmesh
```

## Connect to the node

There are two main ways to connect to the node.
We'll use the `wmctl` utility and the generated `admin.yaml` configuration file to connect to the node.
If you have not downloaded the utlity to your local machine, you can do so now following the steps above for your OS and architecture.

```bash
sudo wmctl connect --config admin.yaml
```

The following errors and warning are to be expected when connecting to a node for the first time:

```bash
time=2023-07-25T15:56:20.846+03:00 level=ERROR msg="failed to get leader" component=store node-id=admin error="node not found"
time=2023-07-25T15:56:48.190+03:00 level=WARN msg="failed to get previous log" component=raft previous-index=21 last-index=0 error="log not found"
```

To see more verbose logs you can pass the `--log-level` flag to the `wmctl` utility.

To verify connectivity, you can use the `wg` utility or try to ping the bootstrap server.

```bash
# By default, the IPv4 network of the mesh will be 172.16.0.0/16
# The first node will have the address 172.16.0.1
ping 172.16.0.1

# You can also use the wg utility to verify connectivity
wg show
```

## Create a network

We did not specify detailed routes or configurations when bootstrapping the network.
By default, only internal network traffic is routed through the mesh.

We have several options for adding routes to the network.

- Use the `wmctl put route` command to add a route to the network.
- Start a node with the `--mesh.routes` flag.

_TODO: Fill this out more_
