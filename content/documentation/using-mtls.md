---
title: Using mTLS
weight: 0
---

The recommended way to authorize and authenticate nodes is via mTLS.
There is a proof-of-concept Kubernetes Operator [here](https://github.com/webmeshproj/operator) that uses [cert-manager](https://cert-manager.io/) to issue certificates for nodes.
In other environments you can use your preferred certificate authority or the included `wmctl` utility.

This document will show how to use `wmctl` to generate certificates for nodes and use them to connect to the Webmesh API.
You'll need to have `wmctl` installed.
It is released as a single binary for Linux, MacOS, and Windows and can be downloaded from the [releases page](https://github.com/webmeshproj/node/releases).
There is no need to configure the CLI when using the `pki` subcommand.

{{< toc >}}

## Initialize a PKI

First we'll initialize a new PKI.
This will create a new root certificate authority and a certificate for the CLI to use.

```bash
wmctl pki --pki-directory ./pki init
```

The only required argument is `--pki-directory` which specifies where the PKI files will be stored.
If you'd like to use alternative names, key types, or key-sizes you can specify them with the command line flags.
Run `wmctl pki init --help` for more information.

When the command completes you should have the following files in the `pki-directory`:

```bash
$ tree ./pki
./pki
├── ca
│   ├── ca.crt
│   ├── tls.crt
│   └── tls.key
└── nodes
    └── admin
        ├── ca.crt
        ├── tls.crt
        └── tls.key
```

The filenames should be self-explanatory.
For each directory, the `ca.crt` file is the root certificate and the `tls.crt` and `tls.key` files are the certificate and private key for the node/user.
The `ca` directory contains the root CA and is required to be present for further commands to work.

## Issuing Certificates

For this example we'll issue two certificates.
One for a bootstrap node and one for a regular node.

```bash
wmctl pki --pki-directory ./pki issue --name bootstrap
wmctl pki --pki-directory ./pki issue --name node
```

The `--name` flag is used to specify the name of the node.
This will be the node's unique identifier in the Webmesh API.
After the command completes you should have the following files in the `pki-directory`:

```bash
$ tree ./pki
./pki
├── ca
│   ├── ca.crt
│   ├── tls.crt
│   └── tls.key
└── nodes
    ├── admin
    │   ├── ca.crt
    │   ├── tls.crt
    │   └── tls.key
    ├── bootstrap
    │   ├── ca.crt
    │   ├── tls.crt
    │   └── tls.key
    └── node
        ├── ca.crt
        ├── tls.crt
        └── tls.key
```

We can use these certificates to start a new cluster.

## Starting a Cluster

When using mTLS the `--global` flags and configurations are particularly useful for applying the certificates to all services.
First, we'll create a new cluster with the bootstrap node.

```bash
docker run --rm --privileged \
    --name=bootstrap \
    --publish 8443:8443 \
    --volume $(pwd)/pki/nodes/bootstrap:/etc/webmesh/tls \
    ghcr.io/webmeshproj/node:latest \
        --global.no-ipv6 \
        --global.detect-endpoints \
        --global.detect-private-endpoints \
        --global.mtls \
        --global.tls-ca-file=/etc/webmesh/tls/ca.crt \
        --global.tls-cert-file=/etc/webmesh/tls/tls.crt \
        --global.tls-key-file=/etc/webmesh/tls/tls.key \
        --global.verify-chain-only \
        --bootstrap.enabled \
        --bootstrap.default-network-policy=accept
```

As explained in the [configuration](../configuration/) section, you may replace the command line flags with environment variables or a configuration file.
Let's break down the command line flags.

- `--global.no-ipv6` - Disable IPv6 support. This is required for Docker for Mac and Docker for Windows. If you're running on Linux you can likely remove this flag.
- `--global.detect-endpoints` - Enable endpoint detection. This will automatically detect the IP address of the node.
- `--global.detect-private-endpoints` - Enable private endpoint detection. This will include private IP addresses in node detection. Since this is just an unexposed docker container we'll need to enable this to detect the private IP address.
- `--global.mtls` - Enable mTLS. This will require all nodes to present a valid certificate signed by the root CA.
- `--global.tls-ca-file` - The path to the root CA certificate.
- `--global.tls-cert-file` - The path to the node's certificate.
- `--global.tls-key-file` - The path to the node's private key.
- `--global.verify-chain-only` - Only verify the certificate chain and presented node ID. This is included because the `pki` subcommand does not include hostnames or IP addresses in the certificate.
- `--bootstrap.enabled` - Enable bootstrapping. This will allow the node to create the cluster.
- `--bootstrap.default-network-policy=accept` - Set the default network policy to accept. This will allow all traffic between nodes.

After the bootstrap node is running we can start the regular node.
Most docker configurations will automatically create a DNS alias for you on the docker network.
For the sake of completeness and avoiding confusion we'll lookup the IP address of the bootstrap node.

```bash
$ docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' bootstrap
192.168.254.2
```

The IP address of the bootstrap node is `192.168.254.2` so we'll use that to join the cluster.

```bash
docker run --rm --privileged \
    --name=node \
    --volume $(pwd)/pki/nodes/node:/etc/webmesh/tls \
    ghcr.io/webmeshproj/node:latest \
        --global.no-ipv6 \
        --global.mtls \
        --global.tls-ca-file=/etc/webmesh/tls/ca.crt \
        --global.tls-cert-file=/etc/webmesh/tls/tls.crt \
        --global.tls-key-file=/etc/webmesh/tls/tls.key \
        --global.verify-chain-only \
        --mesh.join-address=192.168.254.2:8443
```

The flags are the same as the bootstrap node except for `--mesh.join-address` which specifies the address of the node we are joining.
We can inspect the WireGuard interface on each node to verify that they are connected.

```bash
# Bootstrap Node
$ docker exec -it bootstrap wg
interface: webmesh0
  public key: EsTxOwdWRoWbqy8doTf5RvVtcjmoLQhfDE8AKqz6UR0=
  private key: (hidden)
  listening port: 51820

peer: tAMODIbRpmTIDRv8NwhI6ptwvn7p9NcioeLOccxQLTE=
  endpoint: 192.168.254.3:51820
  allowed ips: 172.16.0.2/32, fd2f:62db:84fc:a9c0::/64
  latest handshake: 39 seconds ago
  transfer: 46.99 KiB received, 73.41 KiB sent
  persistent keepalive: every 30 seconds

# Regular Node
$ docker exec -it node wg
interface: webmesh0
  public key: tAMODIbRpmTIDRv8NwhI6ptwvn7p9NcioeLOccxQLTE=
  private key: (hidden)
  listening port: 51820

peer: EsTxOwdWRoWbqy8doTf5RvVtcjmoLQhfDE8AKqz6UR0=
  endpoint: 192.168.254.2:51820
  allowed ips: 172.16.0.1/32
  latest handshake: 1 minute, 13 seconds ago
  transfer: 125.29 KiB received, 81.33 KiB sent
  persistent keepalive: every 30 seconds
```

## Using the API

The `pki` subcommand comes with an additional `gen-config` command that will generate a configuration file for the Webmesh API.
By default it will generate a configuration file for the admin certificate.

```bash
wmctl pki --pki-directory ./pki gen-config --output config.yaml --server localhost:8443
```

A quick look at the flags:

- `--pki-directory` - The directory containing the PKI files.
- `--output` - The path to write the configuration file to.
- `--server` - The address of the Webmesh API server to specify in the configuration file.

We can now use this configuration file to connect to the API.

```bash
# Query the status of the bootstrap node
$ wmctl --config config.yaml status
{
  "id":  "bootstrap",
  "version":  "v0.0.8-4-g41d596f",
  "commit":  "41d596f5096b2ad427b93735eddfc5777f004935",
  "buildDate":  "2023-07-17T13:26:44Z",
  "uptime":  "6m18.313736147s",
  "startedAt":  "2023-07-18T23:59:06.405760583Z",
  "features":  [
    "NODES"
  ],
  "clusterStatus":  "CLUSTER_LEADER",
  "currentLeader":  "bootstrap",
  "currentTerm":  "2",
  "lastLogIndex":  "21",
  "lastApplied":  "21",
  "interfaceMetrics":  {
    "deviceName":  "webmesh0",
    "publicKey":  "EsTxOwdWRoWbqy8doTf5RvVtcjmoLQhfDE8AKqz6UR0=",
    "addressV4":  "172.16.0.1/32",
    "addressV6":  "invalid Prefix",
    "type":  "Linux kernel",
    "listenPort":  51820,
    "totalReceiveBytes":  "266988",
    "totalTransmitBytes":  "406236",
    "numPeers":  1,
    "peers":  [
      {
        "publicKey":  "tAMODIbRpmTIDRv8NwhI6ptwvn7p9NcioeLOccxQLTE=",
        "endpoint":  "192.168.254.3:51820",
        "persistentKeepAlive":  "30s",
        "lastHandshakeTime":  "2023-07-19T00:05:18Z",
        "allowedIps":  [
          "172.16.0.2/32",
          "fd2f:62db:84fc:a9c0::/64"
        ],
        "protocolVersion":  "1",
        "receiveBytes":  "266988",
        "transmitBytes":  "406236"
      }
    ]
  }
}

# Query the status of the regular node
$ wmctl --config config.yaml status node
\{
  "id":  "node",
  "version":  "v0.0.8-4-g41d596f",
  "commit":  "41d596f5096b2ad427b93735eddfc5777f004935",
  "buildDate":  "2023-07-17T13:26:44Z",
  "uptime":  "4m27.697241278s",
  "startedAt":  "2023-07-19T00:01:19.083142992Z",
  "features":  [
    "NODES"
  ],
  "clusterStatus":  "CLUSTER_NON_VOTER",
  "currentLeader":  "bootstrap",
  "currentTerm":  "2",
  "lastLogIndex":  "21",
  "lastApplied":  "21",
  "interfaceMetrics":  {
    "deviceName":  "webmesh0",
    "publicKey":  "tAMODIbRpmTIDRv8NwhI6ptwvn7p9NcioeLOccxQLTE=",
    "addressV4":  "172.16.0.2/32",
    "addressV6":  "invalid Prefix",
    "type":  "Linux kernel",
    "listenPort":  51820,
    "totalReceiveBytes":  "443372",
    "totalTransmitBytes":  "291788",
    "numPeers":  1,
    "peers":  [
      {
        "publicKey":  "EsTxOwdWRoWbqy8doTf5RvVtcjmoLQhfDE8AKqz6UR0=",
        "endpoint":  "192.168.254.2:51820",
        "persistentKeepAlive":  "30s",
        "lastHandshakeTime":  "2023-07-19T00:05:18Z",
        "allowedIps":  [
          "172.16.0.1/32"
        ],
        "protocolVersion":  "1",
        "receiveBytes":  "443372",
        "transmitBytes":  "291788"
      }
    ]
  }
}
```

We didn't enable any other features so the only thing we can do is query the status of the nodes.
See the [Services Configurations](../configuration/#services-configurations) section for more information on enabling features.
