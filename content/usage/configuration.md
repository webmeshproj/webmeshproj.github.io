---
title: Configuration
weight: -10
---

Each node can be configured to bootstrap a new cluster or join an existing cluster.
When bootstrapping a new cluster, the node will become the leader of the cluster.
When joining an existing cluster, the node will attempt to join the cluster by contacting the leader.

Optionally, the node can be configured to bootstrap with a set of initial nodes.
When bootstrapping with initial nodes, the nodes will perform an election to determine which node should write the initial network configuration.
If the initial nodes are already part of a cluster, the node will join the cluster by contacting the leader of the cluster.

Configuration is available via command line flags, environment variables, and configuration files.
The configuration is parsed in the following order:

- Environment Variables
- Command Line Flags
- Configuration File

Environment variables match the command line flags where all characters are uppercased and dashes and dots are replaced with underscores.
For example, the command line flag `mesh.node-id` would be set via the environment variable `MESH_NODE_ID`.

Configuration files can be in YAML, JSON, or TOML.
The configuration file is specified via the "--config" flag.
The configuration file matches the structure of the command line flags.
For example, the following YAML configuration would be equivalent to the shown command line flag:

```yaml
# config.yaml
mesh:
  node-id: "node-1" # --mesh.node-id="node-1"
```

The below tables show all of the available configuration options and their default values.

{{< toc >}}

```
General Flags

  --config         Load flags from the given configuration file
  --print-config   Print the configuration and exit

  --help       Show this help message
  --version    Show version information and exit
```

## Global Configurations

| CLI Flag                            | Env Var                           | Config File                       | Default | Description                                               |
| ----------------------------------- | --------------------------------- | --------------------------------- | ------- | --------------------------------------------------------- |
| `--global.allow-remote-detection`   | `GLOBAL_ALLOW_REMOTE_DETECTION`   | `global.allow-remote-detection`   | `false` | Allow remote detection of the node's public IP address.   |
| `--global.detect-endpoints`         | `GLOBAL_DETECT_ENDPOINTS`         | `global.detect-endpoints`         | `false` | Detect the node's public IP address.                      |
| `--global.detect-private-endpoints` | `GLOBAL_DETECT_PRIVATE_ENDPOINTS` | `global.detect-private-endpoints` | `false` | Include private IP addresses in detection.                |
| `--global.detect-ipv6`              | `GLOBAL_DETECT_IPV6`              | `global.detect-ipv6`              | `false` | Include IPv6 addresses in detection.                      |
| `--global.insecure`                 | `GLOBAL_INSECURE`                 | `global.insecure`                 | `false` | Disable authentication and authorization.                 |
| `--global.no-ipv6`                  | `GLOBAL_NO_IPV6`                  | `global.no-ipv6`                  | `false` | Disable IPv6.                                             |
| `--global.no-ipv4`                  | `GLOBAL_NO_IPV4`                  | `global.no-ipv4`                  | `false` | Disable IPv4.                                             |
| `--global.mtls`                     | `GLOBAL_MTLS`                     | `global.mtls`                     | `false` | Enable mutual TLS globally.                               |
| `--global.primary-endpoint`         | `GLOBAL_PRIMARY_ENDPOINT`         | `global.primary-endpoint`         |         | The node's primary endpoint if exposing as a direct peer. |
| `--global.tls-ca-file`              | `GLOBAL_TLS_CA_FILE`              | `global.tls-ca-file`              |         | The path to the CA certificate file.                      |
| `--global.tls-cert-file`            | `GLOBAL_TLS_CERT_FILE`            | `global.tls-cert-file`            |         | The path to the certificate file.                         |
| `--global.tls-key-file`             | `GLOBAL_TLS_KEY_FILE`             | `global.tls-key-file`             |         | The path to the key file.                                 |
| `--global.verify-chain-only`        | `GLOBAL_VERIFY_CHAIN_ONLY`        | `global.verify-chain-only`        | `false` | Do not verify hostnames or SANs in peer certificates.     |
| `--global.log-level`                | `GLOBAL_LOG_LEVEL`                | `global.log-level`                | `info`  | The log level to use.                                     |

## Mesh Configurations

| CLI Flag                          | Env Var                         | Config File                     | Default      | Description                                                                                                                                                                                                                                                                                                                         |
| --------------------------------- | ------------------------------- | ------------------------------- | ------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--mesh.direct-peers`             | `MESH_DIRECT_PEERS`             | `mesh.direct-peers`             | `[]`         | A list of peers to establish tunnels over ICE with. Requires a node in the network offering ICE negotiation and for the node to be allowed to create direct peerings.                                                                                                                                                               |
| `--mesh.grpc-port`                | `MESH_GRPC_PORT`                | `mesh.grpc-port`                | `8443`       | The port to advertise to other peers for gRPC communication.                                                                                                                                                                                                                                                                        |
| `--mesh.join-address`             | `MESH_JOIN_ADDRESS`             | `mesh.join-address`             |              | The address of a node in the network to join.                                                                                                                                                                                                                                                                                       |
| `--mesh.join-as-voter`            | `MESH_JOIN_AS_VOTER`            | `mesh.join-as-voter`            | `false`      | Whether to join the network as a voter. Requires the node be allowed to vote in elections.                                                                                                                                                                                                                                          |
| `--mesh.join-timeout`             | `MESH_JOIN_TIMEOUT`             | `mesh.join-timeout`             | `60s`        | The amount of time to wait for the node to join the network.                                                                                                                                                                                                                                                                        |
| `--mesh.max-join-retries`         | `MESH_MAX_JOIN_RETRIES`         | `mesh.max-join-retries`         | `10`         | The maximum number of times to retry joining the network.                                                                                                                                                                                                                                                                           |
| `--mesh.no-ipv4`                  | `MESH_NO_IPV4`                  | `mesh.no-ipv4`                  | `false`      | Do not request an IPv4 assignment when joining.                                                                                                                                                                                                                                                                                     |
| `--mesh.no-ipv6`                  | `MESH_NO_IPV6`                  | `mesh.no-ipv6`                  | `false`      | Do not request an IPv6 assignment when joining.                                                                                                                                                                                                                                                                                     |
| `--mesh.node-id`                  | `MESH_NODE_ID`                  | `mesh.node-id`                  | `<hostname>` | The node's unique identifier. If not set, the ID comes from the following decision tree. If mTLS is enabled, the node ID is the CN of the client certificate. If mTLS is not enabled, the node ID is the hostname of the machine. If the hostname is not available, the node ID is a random UUID (should only be used for testing). |
| `--mesh.peer-discovery-addresses` | `MESH_PEER_DISCOVERY_ADDRESSES` | `mesh.peer-discovery-addresses` | `[]`         | A list of addresses to use for peer discovery.                                                                                                                                                                                                                                                                                      |
| `--mesh.primary-endpoint`         | `MESH_PRIMARY_ENDPOINT`         | `mesh.primary-endpoint`         |              | The primary endpoint to broadcast when joining or bootstrapping a cluster. This is only necessary if the node intends on being directly accessible.                                                                                                                                                                                 |
| `--mesh.routes`                   | `MESH_ROUTES`                   | `mesh.routes`                   | `[]`         | A list of routes to advertise to other peers. Requires the node be allowed to broadcast routes.                                                                                                                                                                                                                                     |
| `--mesh.zone-awareness-id`        | `MESH_ZONE_AWARENESS_ID`        | `mesh.zone-awareness-id`        |              | The zone awareness ID to use for the node. When set and peer nodes contain multiple endpoints, addresses in the local LAN will be prioritized.                                                                                                                                                                                      |

## Auth Configurations

_TODO: Generic flags need to be provided for external plugin auth providers_

| CLI Flag                | Env Var               | Config File           | Default | Description                                     |
| ----------------------- | --------------------- | --------------------- | ------- | ----------------------------------------------- |
| `--auth.basic.username` | `AUTH_BASIC_USERNAME` | `auth.basic.username` |         | The username for basic auth.                    |
| `--auth.basic.password` | `AUTH_BASIC_PASSWORD` | `auth.basic.password` |         | The password for basic auth.                    |
| `--auth.ldap.username`  | `AUTH_LDAP_USERNAME`  | `auth.ldap.username`  |         | The username for LDAP auth.                     |
| `--auth.ldap.password`  | `AUTH_LDAP_PASSWORD`  | `auth.ldap.password`  |         | The password for LDAP auth.                     |
| `--auth.mtls.cert-file` | `AUTH_MTLS_CERT_FILE` | `auth.mtls.cert-file` |         | The path to the certificate file for mTLS auth. |
| `--auth.mtls.key-file`  | `AUTH_MTLS_KEY_FILE`  | `auth.mtls.key-file`  |         | The path to the key file for mTLS auth.         |

## Bootstrap Configurations

| CLI Flag                             | Env Var                            | Config File                        | Default             | Description                                                                                                                                         |
| ------------------------------------ | ---------------------------------- | ---------------------------------- | ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--bootstrap.enabled`                | `BOOTSTRAP_ENABLED`                | `bootstrap.enabled`                | `false`             | Whether to bootstrap a new cluster.                                                                                                                 |
| `--bootstrap.admin`                  | `BOOTSTRAP_ADMIN`                  | `bootstrap.admin`                  | `admin`             | The name to use for the admin user.                                                                                                                 |
| `--bootstrap.advertise-address`      | `BOOTSTRAP_ADVERTISE_ADDRESS`      | `bootstrap.advertise-address`      |                     | The address to advertise to other peers when bootstraping with multiple nodes.                                                                      |
| `--bootstrap.default-network-policy` | `BOOTSTRAP_DEFAULT_NETWORK_POLICY` | `bootstrap.default-network-policy` | `deny`              | The default network policy to apply to all nodes. Accepted values are `accept` and `deny`.                                                          |
| `--bootstrap.ipv4-network`           | `BOOTSTRAP_IPV4_NETWORK`           | `bootstrap.ipv4-network`           | `172.16.0.0/12`     | The IPv4 network to use for the cluster.                                                                                                            |
| `--bootstrap.mesh-domain`            | `BOOTSTRAP_MESH_DOMAIN`            | `bootstrap.mesh-domain`            | `webmesh.internal.` | The domain to use for the cluster.                                                                                                                  |
| `--bootstrap.restore-snapshot`       | `BOOTSTRAP_RESTORE_SNAPSHOT`       | `bootstrap.restore-snapshot`       |                     | The path to a snapshot to restore. This is for advanced usage only.                                                                                 |
| `--bootstrap.servers`                | `BOOTSTRAP_SERVERS`                | `bootstrap.servers`                |                     | A list of servers to bootstrap with in the form of `<node_id>=<address>`.                                                                           |
| `--bootstrap.servers-grpc-ports`     | `BOOTSTRAP_SERVERS_GRPC_PORTS`     | `bootstrap.servers-grpc-ports`     |                     | A list of gRPC ports for the servers to bootstrap with in the form of `<node_id>=<port>`. 8443 is assumed for all peers unless otherwise specified. |
| `--bootstrap.force`                  | `BOOTSTRAP_FORCE`                  | `bootstrap.force`                  | `false`             | Whether to force bootstraping a new cluster.                                                                                                        |
| `--bootstrap.voters`                 | `BOOTSTRAP_VOTERS`                 | `bootstrap.voters`                 |                     | A list of additional nodes to assign voting permissions.                                                                                            |

## Raft Configurations

| CLI Flag                       | Env Var                      | Config File                  | Default                  | Description                                                    |
| ------------------------------ | ---------------------------- | ---------------------------- | ------------------------ | -------------------------------------------------------------- |
| `--raft.apply-timeout`         | `RAFT_APPLY_TIMEOUT`         | `raft.apply-timeout`         | `15s`                    | The amount of time to wait for a log entry to be applied.      |
| `--raft.commit-timeout`        | `RAFT_COMMIT_TIMEOUT`        | `raft.commit-timeout`        | `15s`                    | The amount of time to wait for a log entry to be committed.    |
| `--raft.connection-pool-count` | `RAFT_CONNECTION_POOL_COUNT` | `raft.connection-pool-count` | `0`                      | The number of connections to pool for each peer.               |
| `--raft.connection-timeout`    | `RAFT_CONNECTION_TIMEOUT`    | `raft.connection-timeout`    | `3s`                     | The amount of time to wait for a connection to be established. |
| `--raft.data-dir`              | `RAFT_DATA_DIR`              | `raft.data-dir`              | `/var/lib/webmesh/store` | The directory to store Raft data.                              |
| `--raft.election-timeout`      | `RAFT_ELECTION_TIMEOUT`      | `raft.election-timeout`      | `3s`                     | The amount of time to wait for an election to complete.        |
| `--raft.heartbeat-timeout`     | `RAFT_HEARTBEAT_TIMEOUT`     | `raft.heartbeat-timeout`     | `3s`                     | The amount of time to wait between heartbeats.                 |
| `--raft.in-memory`             | `RAFT_IN_MEMORY`             | `raft.in-memory`             | `false`                  | Whether to store Raft data in-memory.                          |
| `--raft.leader-lease-timeout`  | `RAFT_LEADER_LEASE_TIMEOUT`  | `raft.leader-lease-timeout`  | `3s`                     | The amount of time to wait for a leader lease to expire.       |
| `--raft.leave-on-shutdown`     | `RAFT_LEAVE_ON_SHUTDOWN`     | `raft.leave-on-shutdown`     | `false`                  | Whether to leave the cluster when shutting down.               |
| `--raft.listen-address`        | `RAFT_LISTEN_ADDRESS`        | `raft.listen-address`        | `:9443`                  | The address to listen on for Raft communication.               |
| `--raft.log-level`             | `RAFT_LOG_LEVEL`             | `raft.log-level`             | `info`                   | The log level to use for Raft.                                 |
| `--raft.max-append-entries`    | `RAFT_MAX_APPEND_ENTRIES`    | `raft.max-append-entries`    | `15`                     | The maximum number of entries to append to a peer at once.     |
| `--raft.observer-chan-buffer`  | `RAFT_OBSERVER_CHAN_BUFFER`  | `raft.observer-chan-buffer`  | `100`                    | The size of the observer channel buffer.                       |
| `--raft.shutdown-timeout`      | `RAFT_SHUTDOWN_TIMEOUT`      | `raft.shutdown-timeout`      | `1m`                     | The amount of time to wait for the node to shutdown.           |
| `--raft.snapshot-interval`     | `RAFT_SNAPSHOT_INTERVAL`     | `raft.snapshot-interval`     | `3m`                     | The amount of time to wait between snapshots.                  |
| `--raft.snapshot-retention`    | `RAFT_SNAPSHOT_RETENTION`    | `raft.snapshot-retention`    | `3`                      | The number of snapshots to retain.                             |
| `--raft.snapshot-threshold`    | `RAFT_SNAPSHOT_THRESHOLD`    | `raft.snapshot-threshold`    | `5`                      | The number of log entries to wait before taking a snapshot.    |

## TLS Configurations

| CLI Flag                     | Env Var                    | Config File                | Default | Description                           |
| ---------------------------- | -------------------------- | -------------------------- | ------- | ------------------------------------- |
| `--tls.ca-file`              | `TLS_CA_FILE`              | `tls.ca-file`              |         | The path to the CA certificate file.  |
| `--tls.insecure`             | `TLS_INSECURE`             | `tls.insecure`             | `false` | Disable TLS.                          |
| `--tls.insecure-skip-verify` | `TLS_INSECURE_SKIP_VERIFY` | `tls.insecure-skip-verify` | `false` | Disable TLS certificate verification. |
| `--tls.verify-chain-only`    | `TLS_VERIFY_CHAIN_ONLY`    | `tls.verify-chain-only`    | `false` | Do not verify hostnames or SANs.      |

## WireGuard Configurations

| CLI Flag                              | Env Var                             | Config File                         | Default    | Description                                                                                                                         |
| ------------------------------------- | ----------------------------------- | ----------------------------------- | ---------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `--wireguard.endpoints`               | `WIREGUARD_ENDPOINTS`               | `wireguard.endpoints`               | `[]`       | A list of endpoints to broadcast for WireGuard™.                                                                                    |
| `--wireguard.force-interface-name`    | `WIREGUARD_FORCE_INTERFACE_NAME`    | `wireguard.force-interface-name`    | `false`    | Delete any existing interface of the same name when starting.                                                                       |
| `--wireguard.force-tun`               | `WIREGUARD_FORCE_TUN`               | `wireguard.force-tun`               | `false`    | Force the use of a TUN interface.                                                                                                   |
| `--wireguard.interface-name`          | `WIREGUARD_INTERFACE_NAME`          | `wireguard.interface-name`          | `webmesh0` | The name of the WireGuard™ interface. On macOS this defaults to `utun+`.                                                            |
| `--wireguard.key-file`                | `WIREGUARD_KEY_FILE`                | `wireguard.key-file`                |            | The path to the WireGuard™ private key file. If it does not exist, it will be created. If not supplied, keys are kept in-memory.    |
| `--wireguard.key-rotation-interval`   | `WIREGUARD_KEY_ROTATION_INTERVAL`   | `wireguard.key-rotation-interval`   | `168h0m0s` | The amount of time to wait between key rotations.                                                                                   |
| `--wireguard.listen-port`             | `WIREGUARD_LISTEN_PORT`             | `wireguard.listen-port`             | `51820`    | The port to listen on for WireGuard™.                                                                                               |
| `--wireguard.masquerade`              | `WIREGUARD_MASQUERADE`              | `wireguard.masquerade`              | `false`    | Whether to masquerade traffic from the WireGuard™ interface.                                                                        |
| `--wireguard.modprobe`                | `WIREGUARD_MODPROBE`                | `wireguard.modprobe`                | `false`    | Whether to attempt to load the WireGuard™ kernel module on Linux systems.                                                           |
| `--wireguard.mtu`                     | `WIREGUARD_MTU`                     | `wireguard.mtu`                     | `1350`     | The MTU to use for the WireGuard™ interface. Changing this value can cause unintended consequences with peer-to-peer communication. |
| `--wireguard.persistent-keepalive`    | `WIREGUARD_PERSISTENT_KEEPALIVE`    | `wireguard.persistent-keepalive`    | `0s`       | The persistent keepalive interval to use for peers on the WireGuard™ interface.                                                     |
| `--wireguard.record-metrics`          | `WIREGUARD_RECORD_METRICS`          | `wireguard.record-metrics`          | `false`    | Whether to track metrics for the WireGuard™ interface. These can be exposed on the metrics server.                                  |
| `--wireguard.record-metrics-interval` | `WIREGUARD_RECORD_METRICS_INTERVAL` | `wireguard.record-metrics-interval` | `15s`      | The amount of time to wait between recording metrics.                                                                               |

## Services Configurations

| CLI Flag                                    | Env Var                                   | Config File                               | Default                            | Description                                                                                                                     |
| ------------------------------------------- | ----------------------------------------- | ----------------------------------------- | ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| `--services.insecure`                       | `SERVICES_INSECURE`                       | `services.insecure`                       | `false`                            | Disable TLS on the gRPC server.                                                                                                 |
| `--services.listen-address`                 | `SERVICES_LISTEN_ADDRESS`                 | `services.listen-address`                 | `:8443`                            | The address to listen on for the gRPC server.                                                                                   |
| `--services.tls-cert-file`                  | `SERVICES_TLS_CERT_FILE`                  | `services.tls-cert-file`                  |                                    | The path to the certificate file for the gRPC server.                                                                           |
| `--services.tls-key-file`                   | `SERVICES_TLS_KEY_FILE`                   | `services.tls-key-file`                   |                                    | The path to the key file for the gRPC server.                                                                                   |
| `--services.api.admin`                      | `SERVICES_API_ADMIN`                      | `services.api.admin`                      | `false`                            | Whether to enable the admin API.                                                                                                |
| `--services.api.leader-proxy`               | `SERVICES_API_LEADER_PROXY`               | `services.api.leader-proxy`               | `false`                            | Whether to enable the leader proxy API. Requests to this node requiring the leader will be proxied over the WireGuard™ tunnels. |
| `--services.api.mesh`                       | `SERVICES_API_MESH`                       | `services.api.mesh`                       | `false`                            | Whether to enable the mesh API.                                                                                                 |
| `--services.api.peer-discovery`             | `SERVICES_API_PEER_DISCOVERY`             | `services.api.peer-discovery`             | `false`                            | Whether to enable the peer discovery API.                                                                                       |
| `--services.api.proxy-auth.basic.username`  | `SERVICES_API_PROXY_AUTH_BASIC_USERNAME`  | `services.api.proxy-auth.basic.username`  |                                    | The username for basic auth on the leader proxy API.                                                                            |
| `--services.api.proxy-auth.basic.password`  | `SERVICES_API_PROXY_AUTH_BASIC_PASSWORD`  | `services.api.proxy-auth.basic.password`  |                                    | The password for basic auth on the leader proxy API.                                                                            |
| `--services.api.proxy-auth.ldap.username`   | `SERVICES_API_PROXY_AUTH_LDAP_USERNAME`   | `services.api.proxy-auth.ldap.username`   |                                    | The username for LDAP auth on the leader proxy API.                                                                             |
| `--services.api.proxy-auth.ldap.password`   | `SERVICES_API_PROXY_AUTH_LDAP_PASSWORD`   | `services.api.proxy-auth.ldap.password`   |                                    | The password for LDAP auth on the leader proxy API.                                                                             |
| `--services.api.proxy-auth.mtls.cert-file`  | `SERVICES_API_PROXY_AUTH_MTLS_CERT_FILE`  | `services.api.proxy-auth.mtls.cert-file`  |                                    | The path to the certificate file for mTLS auth on the leader proxy API.                                                         |
| `--services.api.proxy-auth.mtls.key-file`   | `SERVICES_API_PROXY_AUTH_MTLS_KEY_FILE`   | `services.api.proxy-auth.mtls.key-file`   |                                    | The path to the key file for mTLS auth on the leader proxy API.                                                                 |
| `--services.api.proxy-insecure`             | `SERVICES_API_PROXY_INSECURE`             | `services.api.proxy-insecure`             | `false`                            | Disable TLS on the leader proxy API.                                                                                            |
| `--services.api.proxy-insecure-skip-verify` | `SERVICES_API_PROXY_INSECURE_SKIP_VERIFY` | `services.api.proxy-insecure-skip-verify` | `false`                            | Disable TLS certificate verification on the leader proxy API.                                                                   |
| `--services.api.proxy-tls-ca-file`          | `SERVICES_API_PROXY_TLS_CA_FILE`          | `services.api.proxy-tls-ca-file`          |                                    | The path to the CA certificate file for the leader proxy API.                                                                   |
| `--services.api.proxy-verify-chain-only`    | `SERVICES_API_PROXY_VERIFY_CHAIN_ONLY`    | `services.api.proxy-verify-chain-only`    | `false`                            | Do not verify hostnames or SANs on the leader proxy API.                                                                        |
| `--services.api.webrtc`                     | `SERVICES_API_WEBRTC`                     | `services.api.webrtc`                     | `false`                            | Whether to enable the WebRTC API. This allows ICE negotiation between peers.                                                    |
| `--services.api.stun-servers`               | `SERVICES_API_STUN_SERVERS`               | `services.api.stun-servers`               | `["stun:stun.l.google.com:19302"]` | A list of STUN servers to use for ICE negotiation.                                                                              |
| `--services.dashboard.enabled`              | `SERVICES_DASHBOARD_ENABLED`              | `services.dashboard.enabled`              | `false`                            | Whether to enable the dashboard.                                                                                                |
| `--services.dashboard.listen-address`       | `SERVICES_DASHBOARD_LISTEN_ADDRESS`       | `services.dashboard.listen-address`       | `:8080`                            | The address to listen on for the dashboard.                                                                                     |
| `--services.dashboard.prefix`               | `SERVICES_DASHBOARD_PREFIX`               | `services.dashboard.prefix`               | `/`                                | The prefix to use for the dashboard.                                                                                            |
| `--services.dashboard.tls-cert-file`        | `SERVICES_DASHBOARD_TLS_CERT_FILE`        | `services.dashboard.tls-cert-file`        |                                    | The path to the certificate file for the dashboard.                                                                             |
| `--services.dashboard.tls-key-file`         | `SERVICES_DASHBOARD_TLS_KEY_FILE`         | `services.dashboard.tls-key-file`         |                                    | The path to the key file for the dashboard.                                                                                     |
| `--services.mesh-dns.enabled`               | `SERVICES_MESH_DNS_ENABLED`               | `services.mesh-dns.enabled`               | `false`                            | Whether to enable the mesh DNS server.                                                                                          |
| `--services.mesh-dns.domain`                | `SERVICES_MESH_DNS_DOMAIN`                | `services.mesh-dns.domain`                | `webmesh.internal`                 | The domain to use for the mesh DNS server.                                                                                      |
| `--services.mesh-dns.enable-compression`    | `SERVICES_MESH_DNS_ENABLE_COMPRESSION`    | `services.mesh-dns.enable-compression`    | `true`                             | Whether to enable compression on the mesh DNS server.                                                                           |
| `--services.mesh-dns.listen-tcp-address`    | `SERVICES_MESH_DNS_LISTEN_TCP_ADDRESS`    | `services.mesh-dns.listen-tcp-address`    | `:5353`                            | The TCP address to listen on for the mesh DNS server.                                                                           |
| `--services.mesh-dns.listen-udp-address`    | `SERVICES_MESH_DNS_LISTEN_UDP_ADDRESS`    | `services.mesh-dns.listen-udp-address`    | `:5353`                            | The UDP address to listen on for the mesh DNS server.                                                                           |
| `--services.mesh-dns.request-timeout`       | `SERVICES_MESH_DNS_REQUEST_TIMEOUT`       | `services.mesh-dns.request-timeout`       | `5s`                               | The amount of time to wait for a response from the mesh DNS server.                                                             |
| `--services.mesh-dns.tsig-key`              | `SERVICES_MESH_DNS_TSIG_KEY`              | `services.mesh-dns.tsig-key`              |                                    | The TSIG key to use for the mesh DNS server.                                                                                    |
| `--services.metrics.enabled`                | `SERVICES_METRICS_ENABLED`                | `services.metrics.enabled`                | `false`                            | Whether to enable the metrics server.                                                                                           |
| `--services.metrics.listen-address`         | `SERVICES_METRICS_LISTEN_ADDRESS`         | `services.metrics.listen-address`         | `:8000`                            | The address to listen on for the metrics server.                                                                                |
| `--services.metrics.path`                   | `SERVICES_METRICS_PATH`                   | `services.metrics.path`                   | `/metrics`                         | The path to use for the metrics server.                                                                                         |
| `--services.turn.enabled`                   | `SERVICES_TURN_ENABLED`                   | `services.turn.enabled`                   | `false`                            | Whether to enable the TURN server.                                                                                              |
| `--services.turn.endpoint`                  | `SERVICES_TURN_ENDPOINT`                  | `services.turn.endpoint`                  |                                    | The endpoint to advertise for the TURN server. If empty, the `public-ip` will be used.                                          |
| `--services.turn.listen-address`            | `SERVICES_TURN_LISTEN_ADDRESS`            | `services.turn.listen-address`            | `0.0.0.0`                          | The address to listen on for the TURN server.                                                                                   |
| `--services.turn.listen-port`               | `SERVICES_TURN_LISTEN_PORT`               | `services.turn.listen-port`               | `3478`                             | The port to listen on for the TURN server.                                                                                      |
| `--services.turn.public-ip`                 | `SERVICES_TURN_PUBLIC_IP`                 | `services.turn.public-ip`                 |                                    | The public IP address to advertise for the TURN server.                                                                         |
| `--services.turn.server-realm`              | `SERVICES_TURN_SERVER_REALM`              | `services.turn.server-realm`              |                                    | The realm to use for the TURN server.                                                                                           |
| `--services.turn.stun-port-range`           | `SERVICES_TURN_STUN_PORT_RANGE`           | `services.turn.stun-port-range`           | `49152-65535`                      | The port range to use for allocating STUN ports.                                                                                |

## Plugin Configurations

| CLI Flag                               | Env Var                              | Config File                          | Default | Description                                                                                                             |
| -------------------------------------- | ------------------------------------ | ------------------------------------ | ------- | ----------------------------------------------------------------------------------------------------------------------- |
| `--plugins.basic-auth.htpasswd-file`   | `PLUGINS_BASIC_AUTH_HTPASSWD_FILE`   | `plugins.basic-auth.htpasswd-file`   |         | The path to the htpasswd file for basic auth.                                                                           |
| `--plugins.ldap.bind-dn`               | `PLUGINS_LDAP_BIND_DN`               | `plugins.ldap.bind-dn`               |         | The bind DN for LDAP auth.                                                                                              |
| `--plugins.ldap.bind-password`         | `PLUGINS_LDAP_BIND_PASSWORD`         | `plugins.ldap.bind-password`         |         | The bind password for LDAP auth.                                                                                        |
| `--plugins.ldap.ca-file`               | `PLUGINS_LDAP_CA_FILE`               | `plugins.ldap.ca-file`               |         | The path to the CA certificate file for LDAP.                                                                           |
| `--plugins.ldap.node-id-attribute`     | `PLUGINS_LDAP_NODE_ID_ATTRIBUTE`     | `plugins.ldap.node-id-attribute`     |         | The attribute to use for the node ID.                                                                                   |
| `--plugins.ldap.server`                | `PLUGINS_LDAP_SERVER`                | `plugins.ldap.server`                |         | The LDAP server to use for LDAP auth.                                                                                   |
| `--plugins.ldap.user-base-dn`          | `PLUGINS_LDAP_USER_BASE_DN`          | `plugins.ldap.user-base-dn`          |         | The base DN for users in LDAP.                                                                                          |
| `--plugins.ldap.user-disabled-value`   | `PLUGINS_LDAP_USER_DISABLED_VALUE`   | `plugins.ldap.user-disabled-value`   |         | The value to use for checking disabled users in LDAP. Any `user-status-attribute` is considered disabled if left unset. |
| `--plugins.ldap.user-id-attribute`     | `PLUGINS_LDAP_USER_ID_ATTRIBUTE`     | `plugins.ldap.user-id-attribute`     |         | The attribute to use for the user ID.                                                                                   |
| `--plugins.ldap.user-status-attribute` | `PLUGINS_LDAP_USER_STATUS_ATTRIBUTE` | `plugins.ldap.user-status-attribute` |         | The attribute to use for the user's disabled status. All users are allowed if left unset.                               |
| `--plugins.mtls.ca-file`               | `PLUGINS_MTLS_CA_FILE`               | `plugins.mtls.ca-file`               |         | The path to the CA certificate file for mTLS.                                                                           |
| `--plugins.localstore.data-dir`        | `PLUGINS_LOCALSTORE_DATA_DIR`        | `plugins.localstore.data-dir`        |         | The path to the directory to store the mesh data.                                                                       |

Local executable plugins can be configured with the `--plugins.local` flag or configuration entry.
These are provided as a list of paths and configurations in the format of `path=/path/to/executable,config1=val1,config2=val2,...`.

External server plugins are configured with the `--plugins.server` flag or configuration entry.
Configurations are the same as the local plugin, but with the addition of server configurations in the format of `server=rpcserver.com:8443[,insecure=true][,tls-ca-file=ca.crt][,tls-key-file=tls.key][,tls-cert-file=tls.crt]`.
