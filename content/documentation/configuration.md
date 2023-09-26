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

- Configuration Files
- Environment Variables
- Command Line Flags

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

| CLI Flag | Env Var | Config File | Default | Description |
| -------- | ------- | ----------- | ------- | ----------- |
| `--global.allow-remote-detection` | `GLOBAL_ALLOW_REMOTE_DETECTION` | `global.allow-remote-detection` | `false` | Allow remote endpoint detection. |
| `--global.detect-endpoints` | `GLOBAL_DETECT_ENDPOINTS` | `global.detect-endpoints` | `false` | Detect and advertise publicly routable endpoints. |
| `--global.detect-ipv6` | `GLOBAL_DETECT_IPV6` | `global.detect-ipv6` | `false` | Detect and advertise IPv6 endpoints. |
| `--global.detect-private-endpoints` | `GLOBAL_DETECT_PRIVATE_ENDPOINTS` | `global.detect-private-endpoints` | `false` | Detect and advertise private endpoints. |
| `--global.disable-ipv4` | `GLOBAL_DISABLE_IPV4` | `global.disable-ipv4` | `false` | Disable IPv4. |
| `--global.disable-ipv6` | `GLOBAL_DISABLE_IPV6` | `global.disable-ipv6` | `false` | Disable IPv6. |
| `--global.endpoints` | `GLOBAL_ENDPOINTS` | `global.endpoints` | `[]` | Additional endpoints to advertise when joining. |
| `--global.insecure` | `GLOBAL_INSECURE` | `global.insecure` | `false` | Disable TLS. |
| `--global.insecure-skip-verify` | `GLOBAL_INSECURE_SKIP_VERIFY` | `global.insecure-skip-verify` | `false` | Skip TLS verification. |
| `--global.log-level` | `GLOBAL_LOG_LEVEL` | `global.log-level` | `info` | Log level. |
| `--global.mtls` | `GLOBAL_MTLS` | `global.mtls` | `false` | Enable mutual TLS. |
| `--global.primary-endpoint` | `GLOBAL_PRIMARY_ENDPOINT` | `global.primary-endpoint` |  | Primary endpoint to advertise when joining. |
| `--global.tls-ca-file` | `GLOBAL_TLS_CA_FILE` | `global.tls-ca-file` |  | TLS CA file. |
| `--global.tls-cert-file` | `GLOBAL_TLS_CERT_FILE` | `global.tls-cert-file` |  | TLS certificate file. |
| `--global.tls-client-ca-file` | `GLOBAL_TLS_CLIENT_CA_FILE` | `global.tls-client-ca-file` |  | TLS client CA file. |
| `--global.tls-key-file` | `GLOBAL_TLS_KEY_FILE` | `global.tls-key-file` |  | TLS key file. |
| `--global.verify-chain-only` | `GLOBAL_VERIFY_CHAIN_ONLY` | `global.verify-chain-only` | `false` | Verify only the certificate chain. |

## Mesh Configurations

| CLI Flag | Env Var | Config File | Default | Description |
| -------- | ------- | ----------- | ------- | ----------- |
| `--mesh.disable-feature-advertisement` | `MESH_DISABLE_FEATURE_ADVERTISEMENT` | `mesh.disable-feature-advertisement` | `false` | Disable feature advertisement. |
| `--mesh.disable-ipv4` | `MESH_DISABLE_IPV4` | `mesh.disable-ipv4` | `false` | Disable IPv4 usage. |
| `--mesh.disable-ipv6` | `MESH_DISABLE_IPV6` | `mesh.disable-ipv6` | `false` | Disable IPv6 usage. |
| `--mesh.grpc-advertise-port` | `MESH_GRPC_ADVERTISE_PORT` | `mesh.grpc-advertise-port` | `8443` | Port to advertise for gRPC. |
| `--mesh.ice-peers` | `MESH_ICE_PEERS` | `mesh.ice-peers` | `[]` | Peers to request direct edges to over ICE. |
| `--mesh.join-address` | `MESH_JOIN_ADDRESS` | `mesh.join-address` |  | Address of a node to join. |
| `--mesh.libp2p-peers` | `MESH_LIBP2P_PEERS` | `mesh.libp2p-peers` | `[]` | Map of peer IDs to rendezvous strings for edges over libp2p. |
| `--mesh.max-join-retries` | `MESH_MAX_JOIN_RETRIES` | `mesh.max-join-retries` | `15` | Maximum number of join retries. |
| `--mesh.meshdns-advertise-port` | `MESH_MESHDNS_ADVERTISE_PORT` | `mesh.meshdns-advertise-port` | `53` | Port to advertise for DNS. |
| `--mesh.node-id` | `MESH_NODE_ID` | `mesh.node-id` |  | Node ID. One will be chosen automatically if left unset. |
| `--mesh.primary-endpoint` | `MESH_PRIMARY_ENDPOINT` | `mesh.primary-endpoint` |  | Primary endpoint to advertise when joining. |
| `--mesh.request-observer` | `MESH_REQUEST_OBSERVER` | `mesh.request-observer` | `false` | Request to be an observer in the storage backend. |
| `--mesh.request-vote` | `MESH_REQUEST_VOTE` | `mesh.request-vote` | `false` | Request a vote in elections for the storage backend. |
| `--mesh.routes` | `MESH_ROUTES` | `mesh.routes` | `[]` | Additional routes to advertise to the mesh. |
| `--mesh.storage-prefer-ipv6` | `MESH_STORAGE_PREFER_IPV6` | `mesh.storage-prefer-ipv6` | `false` | Prefer IPv6 connections for the storage backend transport. |
| `--mesh.use-meshdns` | `MESH_USE_MESHDNS` | `mesh.use-meshdns` | `false` | Set mesh DNS servers to the system configuration. |
| `--mesh.zone-awareness-id` | `MESH_ZONE_AWARENESS_ID` | `mesh.zone-awareness-id` |  | Zone awareness ID. |

## Auth Configurations

| CLI Flag | Env Var | Config File | Default | Description |
| -------- | ------- | ----------- | ------- | ----------- |
| `--auth.basic.password` | `AUTH_BASIC_PASSWORD` | `auth.basic.password` |  | Basic auth password. |
| `--auth.basic.username` | `AUTH_BASIC_USERNAME` | `auth.basic.username` |  | Basic auth username. |
| `--auth.ldap.password` | `AUTH_LDAP_PASSWORD` | `auth.ldap.password` |  | LDAP auth password. |
| `--auth.ldap.username` | `AUTH_LDAP_USERNAME` | `auth.ldap.username` |  | LDAP auth username. |
| `--auth.mtls.cert-data` | `AUTH_MTLS_CERT_DATA` | `auth.mtls.cert-data` |  | Base64 encoded TLS certificate data to present when joining. |
| `--auth.mtls.cert-file` | `AUTH_MTLS_CERT_FILE` | `auth.mtls.cert-file` |  | Path to a TLS certificate file to present when joining. |
| `--auth.mtls.key-data` | `AUTH_MTLS_KEY_DATA` | `auth.mtls.key-data` |  | Base64 encoded TLS key data for the certificate. |
| `--auth.mtls.key-file` | `AUTH_MTLS_KEY_FILE` | `auth.mtls.key-file` |  | Path to a TLS key file for the certificate. |

_TODO: Generic flags need to be provided for external plugin auth providers_

## Bootstrap Configurations

| CLI Flag | Env Var | Config File | Default | Description |
| -------- | ------- | ----------- | ------- | ----------- |
| `--bootstrap.admin` | `BOOTSTRAP_ADMIN` | `bootstrap.admin` | `admin` | User and/or node name to assign administrator privileges to when bootstraping a new cluster |
| `--bootstrap.default-network-policy` | `BOOTSTRAP_DEFAULT_NETWORK_POLICY` | `bootstrap.default-network-policy` | `accept` | Default network policy to apply to the mesh when bootstraping a new cluster |
| `--bootstrap.disable-rbac` | `BOOTSTRAP_DISABLE_RBAC` | `bootstrap.disable-rbac` | `false` | Disable RBAC when bootstrapping a new cluster |
| `--bootstrap.election-timeout` | `BOOTSTRAP_ELECTION_TIMEOUT` | `bootstrap.election-timeout` | `3s` | Election timeout to use when bootstrapping a new cluster |
| `--bootstrap.enabled` | `BOOTSTRAP_ENABLED` | `bootstrap.enabled` | `false` | Attempt to bootstrap a new cluster |
| `--bootstrap.force` | `BOOTSTRAP_FORCE` | `bootstrap.force` | `false` | Force new bootstrap |
| `--bootstrap.ipv4-network` | `BOOTSTRAP_IPV4_NETWORK` | `bootstrap.ipv4-network` | `172.16.0.0/12` | IPv4 network of the mesh to write to the database when bootstraping a new cluster |
| `--bootstrap.mesh-domain` | `BOOTSTRAP_MESH_DOMAIN` | `bootstrap.mesh-domain` | `webmesh.internal` | Domain of the mesh to write to the database when bootstraping a new cluster |
| `--bootstrap.transport.psk` | `BOOTSTRAP_TRANSPORT_PSK` | `bootstrap.transport.psk` |  | Pre-shared key to use when using libp2p to bootstrap |
| `--bootstrap.transport.rendezvous` | `BOOTSTRAP_TRANSPORT_RENDEZVOUS` | `bootstrap.transport.rendezvous` |  | Rendezvous string to use when using libp2p to bootstrap |
| `--bootstrap.transport.rendezvous-linger` | `BOOTSTRAP_TRANSPORT_RENDEZVOUS_LINGER` | `bootstrap.transport.rendezvous-linger` | `1m0s` | Amount of time to wait for other nodes to join when using libp2p to bootstrap |
| `--bootstrap.transport.rendezvous-nodes` | `BOOTSTRAP_TRANSPORT_RENDEZVOUS_NODES` | `bootstrap.transport.rendezvous-nodes` | `[]` | List of node IDs to use when using libp2p to bootstrap |
| `--bootstrap.transport.server-grpc-ports` | `BOOTSTRAP_TRANSPORT_SERVER_GRPC_PORTS` | `bootstrap.transport.server-grpc-ports` | `[]` | Map of node IDs to gRPC ports to bootstrap with |
| `--bootstrap.transport.tcp-advertise-address` | `BOOTSTRAP_TRANSPORT_TCP_ADVERTISE_ADDRESS` | `bootstrap.transport.tcp-advertise-address` |  | Address to advertise for raft consensus |
| `--bootstrap.transport.tcp-connect-timeout` | `BOOTSTRAP_TRANSPORT_TCP_CONNECT_TIMEOUT` | `bootstrap.transport.tcp-connect-timeout` | `3s` | Maximum amount of time to wait for a TCP connection to be established |
| `--bootstrap.transport.tcp-connection-pool` | `BOOTSTRAP_TRANSPORT_TCP_CONNECTION_POOL` | `bootstrap.transport.tcp-connection-pool` | `0` | Maximum number of TCP connections to maintain to other nodes |
| `--bootstrap.transport.tcp-listen-address` | `BOOTSTRAP_TRANSPORT_TCP_LISTEN_ADDRESS` | `bootstrap.transport.tcp-listen-address` | `[::]:9001` | Address to use when using TCP raft consensus to bootstrap |
| `--bootstrap.transport.tcp-servers` | `BOOTSTRAP_TRANSPORT_TCP_SERVERS` | `bootstrap.transport.tcp-servers` | `[]` | Map of node IDs to raft addresses to bootstrap with |
| `--bootstrap.voters` | `BOOTSTRAP_VOTERS` | `bootstrap.voters` | `[]` | Comma separated list of node IDs to assign voting privileges to when bootstraping a new cluster |

## Storage Configurations

| CLI Flag | Env Var | Config File | Default | Description |
| -------- | ------- | ----------- | ------- | ----------- |
| `--storage.in-memory` | `STORAGE_IN_MEMORY` | `storage.in-memory` | `false` | Use in-memory storage |
| `--storage.log-level` | `STORAGE_LOG_LEVEL` | `storage.log-level` | `info` | Log level for the storage provider |
| `--storage.path` | `STORAGE_PATH` | `storage.path` | `/var/lib/webmesh/store` | Path to the storage directory |
| `--storage.provider` | `STORAGE_PROVIDER` | `storage.provider` | `raft` | Storage provider (defaults to raftstorage or passthrough depending on other options) |

### Raft Storage Configurations

| CLI Flag | Env Var | Config File | Default | Description |
| -------- | ------- | ----------- | ------- | ----------- |
| `--storage.raft.apply-timeout` | `STORAGE_RAFT_APPLY_TIMEOUT` | `storage.raft.apply-timeout` | `10s` | Raft apply timeout. |
| `--storage.raft.commit-timeout` | `STORAGE_RAFT_COMMIT_TIMEOUT` | `storage.raft.commit-timeout` | `10s` | Raft commit timeout. |
| `--storage.raft.connection-pool-count` | `STORAGE_RAFT_CONNECTION_POOL_COUNT` | `storage.raft.connection-pool-count` | `0` | Raft connection pool count. |
| `--storage.raft.connection-timeout` | `STORAGE_RAFT_CONNECTION_TIMEOUT` | `storage.raft.connection-timeout` | `3s` | Raft connection timeout. |
| `--storage.raft.election-timeout` | `STORAGE_RAFT_ELECTION_TIMEOUT` | `storage.raft.election-timeout` | `2s` | Raft election timeout. |
| `--storage.raft.heartbeat-purge-threshold` | `STORAGE_RAFT_HEARTBEAT_PURGE_THRESHOLD` | `storage.raft.heartbeat-purge-threshold` | `25` | Raft heartbeat purge threshold. |
| `--storage.raft.heartbeat-timeout` | `STORAGE_RAFT_HEARTBEAT_TIMEOUT` | `storage.raft.heartbeat-timeout` | `2s` | Raft heartbeat timeout. |
| `--storage.raft.leader-lease-timeout` | `STORAGE_RAFT_LEADER_LEASE_TIMEOUT` | `storage.raft.leader-lease-timeout` | `2s` | Raft leader lease timeout. |
| `--storage.raft.listen-address` | `STORAGE_RAFT_LISTEN_ADDRESS` | `storage.raft.listen-address` | `[::]:9000` | Raft listen address. |
| `--storage.raft.max-append-entries` | `STORAGE_RAFT_MAX_APPEND_ENTRIES` | `storage.raft.max-append-entries` | `64` | Raft max append entries. |
| `--storage.raft.observer-chan-buffer` | `STORAGE_RAFT_OBSERVER_CHAN_BUFFER` | `storage.raft.observer-chan-buffer` | `100` | Raft observer channel buffer. |
| `--storage.raft.snapshot-interval` | `STORAGE_RAFT_SNAPSHOT_INTERVAL` | `storage.raft.snapshot-interval` | `30s` | Raft snapshot interval. |
| `--storage.raft.snapshot-retention` | `STORAGE_RAFT_SNAPSHOT_RETENTION` | `storage.raft.snapshot-retention` | `2` | Raft snapshot retention. |
| `--storage.raft.snapshot-threshold` | `STORAGE_RAFT_SNAPSHOT_THRESHOLD` | `storage.raft.snapshot-threshold` | `8192` | Raft snapshot threshold. |

### External Storage Configurations

| CLI Flag | Env Var | Config File | Default | Description |
| -------- | ------- | ----------- | ------- | ----------- |
| `--storage.external.config` | `STORAGE_EXTERNAL_CONFIG` | `storage.external.config` |  | Configuration to pass to the plugin as key value pairs |
| `--storage.external.insecure` | `STORAGE_EXTERNAL_INSECURE` | `storage.external.insecure` | `false` | Use an insecure connection to the plugin server |
| `--storage.external.server` | `STORAGE_EXTERNAL_SERVER` | `storage.external.server` |  | Address of a server for the plugin |
| `--storage.external.tls-ca-file` | `STORAGE_EXTERNAL_TLS_CA_FILE` | `storage.external.tls-ca-file` |  | Path to a CA for verifying certificates |
| `--storage.external.tls-cert-file` | `STORAGE_EXTERNAL_TLS_CERT_FILE` | `storage.external.tls-cert-file` |  | Path to a certificate for authenticating to the plugin server |
| `--storage.external.tls-key-file` | `STORAGE_EXTERNAL_TLS_KEY_FILE` | `storage.external.tls-key-file` |  | Path to a key for authenticating to the plugin server |
| `--storage.external.tls-skip-verify` | `STORAGE_EXTERNAL_TLS_SKIP_VERIFY` | `storage.external.tls-skip-verify` | `false` | Skip verifying the plugin server's certificate |

## TLS Configurations

| CLI Flag | Env Var | Config File | Default | Description |
| -------- | ------- | ----------- | ------- | ----------- |
| `--tls.ca-data` | `TLS_CA_DATA` | `tls.ca-data` |  | Base64 encoded TLS CA certificate for verifying peer certificates. |
| `--tls.ca-file` | `TLS_CA_FILE` | `tls.ca-file` |  | Path to a TLS CA certificate for verifying peer certificates. |
| `--tls.insecure` | `TLS_INSECURE` | `tls.insecure` | `false` | Disable TLS. |
| `--tls.insecure-skip-verify` | `TLS_INSECURE_SKIP_VERIFY` | `tls.insecure-skip-verify` | `false` | Skip verification of the server TLS cert. |
| `--tls.verify-chain-only` | `TLS_VERIFY_CHAIN_ONLY` | `tls.verify-chain-only` | `false` | Verify only the certificate chain. |

## WireGuard Configurations

| CLI Flag | Env Var | Config File | Default | Description |
| -------- | ------- | ----------- | ------- | ----------- |
| `--wireguard.endpoints` | `WIREGUARD_ENDPOINTS` | `wireguard.endpoints` | `[]` | Additional WireGuard endpoints to broadcast when joining. |
| `--wireguard.force-interface-name` | `WIREGUARD_FORCE_INTERFACE_NAME` | `wireguard.force-interface-name` | `false` | Force the use of the given name by deleting any pre-existing interface with the same name. |
| `--wireguard.force-tun` | `WIREGUARD_FORCE_TUN` | `wireguard.force-tun` | `false` | Force the use of a TUN interface. |
| `--wireguard.interface-name` | `WIREGUARD_INTERFACE_NAME` | `wireguard.interface-name` | `webmesh+` | The name of the interface. |
| `--wireguard.key-file` | `WIREGUARD_KEY_FILE` | `wireguard.key-file` |  | The path to the WireGuard private key. If it does not exist it will be created. |
| `--wireguard.key-rotation-interval` | `WIREGUARD_KEY_ROTATION_INTERVAL` | `wireguard.key-rotation-interval` | `168h0m0s` | The interval to rotate wireguard keys. Set this to 0 to disable key rotation. |
| `--wireguard.listen-port` | `WIREGUARD_LISTEN_PORT` | `wireguard.listen-port` | `51820` | The port to listen on. |
| `--wireguard.masquerade` | `WIREGUARD_MASQUERADE` | `wireguard.masquerade` | `false` | Enable masquerading of traffic from the wireguard interface. |
| `--wireguard.mtu` | `WIREGUARD_MTU` | `wireguard.mtu` | `1420` | The MTU to use for the interface. |
| `--wireguard.persistent-keepalive` | `WIREGUARD_PERSISTENT_KEEPALIVE` | `wireguard.persistent-keepalive` | `0s` | The interval at which to send keepalive packets to peers. |
| `--wireguard.record-metrics` | `WIREGUARD_RECORD_METRICS` | `wireguard.record-metrics` | `false` | Record WireGuard metrics. These are only exposed if the metrics server is enabled. |
| `--wireguard.record-metrics-interval` | `WIREGUARD_RECORD_METRICS_INTERVAL` | `wireguard.record-metrics-interval` | `10s` | The interval at which to update WireGuard metrics. |

## Discovery Configurations

| CLI Flag | Env Var | Config File | Default | Description |
| -------- | ------- | ----------- | ------- | ----------- |
| `--discovery.announce` | `DISCOVERY_ANNOUNCE` | `discovery.announce` | `false` | announce this peer to the discovery service |
| `--discovery.announce-ttl` | `DISCOVERY_ANNOUNCE_TTL` | `discovery.announce-ttl` | `1m0s` | TTL for the announcement |
| `--discovery.bootstrap-servers` | `DISCOVERY_BOOTSTRAP_SERVERS` | `discovery.bootstrap-servers` | `[]` | list of bootstrap servers to use for the DHT |
| `--discovery.connect-timeout` | `DISCOVERY_CONNECT_TIMEOUT` | `discovery.connect-timeout` | `5s` | timeout for connecting to a peer |
| `--discovery.discover` | `DISCOVERY_DISCOVER` | `discovery.discover` | `false` | use the libp2p kademlia DHT for discovery |
| `--discovery.local-addrs` | `DISCOVERY_LOCAL_ADDRS` | `discovery.local-addrs` | `[]` | list of local addresses to announce to the discovery service |
| `--discovery.rendezvous` | `DISCOVERY_RENDEZVOUS` | `discovery.rendezvous` |  | pre-shared key to use as a rendezvous point for peer discovery |

## Services Configurations

| CLI Flag | Env Var | Config File | Default | Description |
| -------- | ------- | ----------- | ------- | ----------- |
| `--services.api.admin-enabled` | `SERVICES_API_ADMIN_ENABLED` | `services.api.admin-enabled` | `false` | Enable and register the AdminAPI. |
| `--services.api.disable-leader-proxy` | `SERVICES_API_DISABLE_LEADER_PROXY` | `services.api.disable-leader-proxy` | `false` | Disable the leader proxy. |
| `--services.api.disabled` | `SERVICES_API_DISABLED` | `services.api.disabled` | `false` | Disable the API. This is ignored when joining as a Raft member. |
| `--services.api.insecure` | `SERVICES_API_INSECURE` | `services.api.insecure` | `false` | Disable TLS. |
| `--services.api.listen-address` | `SERVICES_API_LISTEN_ADDRESS` | `services.api.listen-address` | `[::]:8443` | gRPC listen address. |
| `--services.api.mesh-enabled` | `SERVICES_API_MESH_ENABLED` | `services.api.mesh-enabled` | `false` | Enable and register the MeshAPI. |
| `--services.api.tls-cert-data` | `SERVICES_API_TLS_CERT_DATA` | `services.api.tls-cert-data` |  | TLS certificate data. |
| `--services.api.tls-cert-file` | `SERVICES_API_TLS_CERT_FILE` | `services.api.tls-cert-file` |  | TLS certificate file. |
| `--services.api.tls-key-data` | `SERVICES_API_TLS_KEY_DATA` | `services.api.tls-key-data` |  | TLS key data. |
| `--services.api.tls-key-file` | `SERVICES_API_TLS_KEY_FILE` | `services.api.tls-key-file` |  | TLS key file. |
| `--services.api.web-enabled` | `SERVICES_API_WEB_ENABLED` | `services.api.web-enabled` | `false` | Enable gRPC over HTTP/1.1. |
| `--services.meshdns.cache-size` | `SERVICES_MESHDNS_CACHE_SIZE` | `services.meshdns.cache-size` | `100` | Size of the remote DNS cache (0 = disabled). |
| `--services.meshdns.compression` | `SERVICES_MESHDNS_COMPRESSION` | `services.meshdns.compression` | `true` | Enable DNS compression. |
| `--services.meshdns.disable-forwarding` | `SERVICES_MESHDNS_DISABLE_FORWARDING` | `services.meshdns.disable-forwarding` | `false` | Disable forwarding requests. |
| `--services.meshdns.enabled` | `SERVICES_MESHDNS_ENABLED` | `services.meshdns.enabled` | `false` | Enable mesh DNS. |
| `--services.meshdns.forwarders` | `SERVICES_MESHDNS_FORWARDERS` | `services.meshdns.forwarders` | `[]` | DNS forwarders (default = system resolvers). |
| `--services.meshdns.ipv6-only` | `SERVICES_MESHDNS_IPV6_ONLY` | `services.meshdns.ipv6-only` | `false` | Only respond to IPv6 requests. |
| `--services.meshdns.listen-tcp` | `SERVICES_MESHDNS_LISTEN_TCP` | `services.meshdns.listen-tcp` | `[::]:53` | TCP address to listen on for DNS requests. |
| `--services.meshdns.listen-udp` | `SERVICES_MESHDNS_LISTEN_UDP` | `services.meshdns.listen-udp` | `[::]:53` | UDP address to listen on for DNS requests. |
| `--services.meshdns.request-timeout` | `SERVICES_MESHDNS_REQUEST_TIMEOUT` | `services.meshdns.request-timeout` | `5s` | DNS request timeout. |
| `--services.meshdns.reuse-port` | `SERVICES_MESHDNS_REUSE_PORT` | `services.meshdns.reuse-port` | `0` | Enable SO_REUSEPORT for mesh DNS. Only available on Linux systems. |
| `--services.meshdns.subscribe-forwarders` | `SERVICES_MESHDNS_SUBSCRIBE_FORWARDERS` | `services.meshdns.subscribe-forwarders` | `false` | Subscribe to new nodes that can forward requests. |
| `--services.metrics.enabled` | `SERVICES_METRICS_ENABLED` | `services.metrics.enabled` | `false` | Enable gRPC metrics. |
| `--services.metrics.listen-address` | `SERVICES_METRICS_LISTEN_ADDRESS` | `services.metrics.listen-address` | `[::]:8080` | gRPC metrics listen address. |
| `--services.metrics.path` | `SERVICES_METRICS_PATH` | `services.metrics.path` | `/metrics` | gRPC metrics path. |
| `--services.turn.enabled` | `SERVICES_TURN_ENABLED` | `services.turn.enabled` | `false` | Enable TURN server. |
| `--services.turn.endpoint` | `SERVICES_TURN_ENDPOINT` | `services.turn.endpoint` |  | TURN endpoint to advertise. |
| `--services.turn.listen-address` | `SERVICES_TURN_LISTEN_ADDRESS` | `services.turn.listen-address` | `[::]:3478` | Address to listen on for STUN/TURN requests. |
| `--services.turn.port-range` | `SERVICES_TURN_PORT_RANGE` | `services.turn.port-range` | `49152-65535` | Port range to use for TURN relays. |
| `--services.turn.public-ip` | `SERVICES_TURN_PUBLIC_IP` | `services.turn.public-ip` |  | Public IP to advertise for STUN/TURN requests. |
| `--services.turn.realm` | `SERVICES_TURN_REALM` | `services.turn.realm` | `webmesh` | Realm used for TURN server authentication. |
| `--services.webrtc.enabled` | `SERVICES_WEBRTC_ENABLED` | `services.webrtc.enabled` | `false` | Enable and register the WebRTC API. |
| `--services.webrtc.stun-servers` | `SERVICES_WEBRTC_STUN_SERVERS` | `services.webrtc.stun-servers` | `[stun:stun.l.google.com:19302]` | TURN/STUN servers to use for the WebRTC API. |

## Plugin Configurations

| CLI Flag | Env Var | Config File | Default | Description |
| -------- | ------- | ----------- | ------- | ----------- |
| `--plugins.basic-auth.htpasswd-file` | `PLUGINS_BASIC_AUTH_HTPASSWD_FILE` | `plugins.basic-auth.htpasswd-file` |  | path to htpasswd file |
| `--plugins.debug.disable-pprof` | `PLUGINS_DEBUG_DISABLE_PPROF` | `plugins.debug.disable-pprof` | `false` | Disable pprof |
| `--plugins.debug.enable-db-querier` | `PLUGINS_DEBUG_ENABLE_DB_QUERIER` | `plugins.debug.enable-db-querier` | `false` | Enable database querier |
| `--plugins.debug.listen-address` | `PLUGINS_DEBUG_LISTEN_ADDRESS` | `plugins.debug.listen-address` | `localhost:6060` | Address to lissten on |
| `--plugins.debug.path-prefix` | `PLUGINS_DEBUG_PATH_PREFIX` | `plugins.debug.path-prefix` | `/debug` | Path prefix to use for the debug server |
| `--plugins.debug.pprof-profiles` | `PLUGINS_DEBUG_PPROF_PROFILES` | `plugins.debug.pprof-profiles` |  | Pprof profiles to enable (default: all) |
| `--plugins.ipam.static-ipv4` | `PLUGINS_IPAM_STATIC_IPV4` | `plugins.ipam.static-ipv4` |  | Static IPv4 addresses to assign to nodes |
| `--plugins.ldap.bind-dn` | `PLUGINS_LDAP_BIND_DN` | `plugins.ldap.bind-dn` |  | DN to bind with |
| `--plugins.ldap.bind-password` | `PLUGINS_LDAP_BIND_PASSWORD` | `plugins.ldap.bind-password` |  | Password to bind with |
| `--plugins.ldap.ca-file` | `PLUGINS_LDAP_CA_FILE` | `plugins.ldap.ca-file` |  | Path to CA file to use to verify the LDAP server's certificate |
| `--plugins.ldap.node-id-attribute` | `PLUGINS_LDAP_NODE_ID_ATTRIBUTE` | `plugins.ldap.node-id-attribute` |  | Attribute to use to identify the node |
| `--plugins.ldap.server` | `PLUGINS_LDAP_SERVER` | `plugins.ldap.server` |  | LDAP server to connect to |
| `--plugins.ldap.user-base-dn` | `PLUGINS_LDAP_USER_BASE_DN` | `plugins.ldap.user-base-dn` |  | Base DN to use to search for users |
| `--plugins.ldap.user-disabled-value` | `PLUGINS_LDAP_USER_DISABLED_VALUE` | `plugins.ldap.user-disabled-value` |  | Value of the user status attribute that indicates the user is disabled |
| `--plugins.ldap.user-id-attribute` | `PLUGINS_LDAP_USER_ID_ATTRIBUTE` | `plugins.ldap.user-id-attribute` |  | Attribute to use to identify the user |
| `--plugins.ldap.user-status-attribute` | `PLUGINS_LDAP_USER_STATUS_ATTRIBUTE` | `plugins.ldap.user-status-attribute` |  | Attribute to use to determine if the user is disabled |
| `--plugins.mtls.ca-file` | `PLUGINS_MTLS_CA_FILE` | `plugins.mtls.ca-file` |  | Path to a CA file to use to verify client certificates. |

