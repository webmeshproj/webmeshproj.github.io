---
title: Bridge Configuration
weight: -9
---

In bridge mode, the options are identical to the node command, except you define multiple mesh connections.
Each mesh connection is defined by a unique mesh ID and it's connection and service options.
One notable exception is that MeshDNS servers defined on the mesh level are ignored in favor of the global one.

In contrast to a regular node, environment variables are not supported.
They will take precedence over the defaults in some cases, but not all.
Global flags are supported, but do not override TLS and some WireGuard configurations.
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
| `--global.log-format` | `GLOBAL_LOG_FORMAT` | `global.log-format` | `text` | Log format. One of 'text' or 'json'. |
| `--global.log-level` | `GLOBAL_LOG_LEVEL` | `global.log-level` | `info` | Log level. |
| `--global.mtls` | `GLOBAL_MTLS` | `global.mtls` | `false` | Enable mutual TLS. |
| `--global.primary-endpoint` | `GLOBAL_PRIMARY_ENDPOINT` | `global.primary-endpoint` |  | Primary endpoint to advertise when joining. |
| `--global.tls-ca-file` | `GLOBAL_TLS_CA_FILE` | `global.tls-ca-file` |  | TLS CA file. |
| `--global.tls-cert-file` | `GLOBAL_TLS_CERT_FILE` | `global.tls-cert-file` |  | TLS certificate file. |
| `--global.tls-client-ca-file` | `GLOBAL_TLS_CLIENT_CA_FILE` | `global.tls-client-ca-file` |  | TLS client CA file. |
| `--global.tls-key-file` | `GLOBAL_TLS_KEY_FILE` | `global.tls-key-file` |  | TLS key file. |
| `--global.verify-chain-only` | `GLOBAL_VERIFY_CHAIN_ONLY` | `global.verify-chain-only` | `false` | Verify only the certificate chain. |

## Mesh DNS Server Configurations

| CLI Flag | Config File | Default | Description |
| -------- | ----------- | ------- | ----------- |
| `--bridge.meshdns.cache-size` | `bridge.meshdns.cache-size` | `0` | Size of the remote DNS cache (0 = disabled). |
| `--bridge.meshdns.compression` | `bridge.meshdns.compression` | `true` | Enable DNS compression. |
| `--bridge.meshdns.disable-forwarding` | `bridge.meshdns.disable-forwarding` | `false` | Disable forwarding requests. |
| `--bridge.meshdns.enabled` | `bridge.meshdns.enabled` | `false` | Enable mesh DNS. |
| `--bridge.meshdns.forwarders` | `bridge.meshdns.forwarders` | `[]` | DNS forwarders (default = bridged resolvers). |
| `--bridge.meshdns.listen-tcp` | `bridge.meshdns.listen-tcp` | `[::]:53` | TCP address to listen on for DNS requests. |
| `--bridge.meshdns.listen-udp` | `bridge.meshdns.listen-udp` | `[::]:53` | UDP address to listen on for DNS requests. |
| `--bridge.meshdns.request-timeout` | `bridge.meshdns.request-timeout` | `5s` | DNS request timeout. |
| `--bridge.meshdns.reuse-port` | `bridge.meshdns.reuse-port` | `0` | Enable SO_REUSEPORT for mesh DNS. Only available on Linux systems. |
| `--bridge.meshdns.subscribe-forwarders` | `bridge.meshdns.subscribe-forwarders` | `true` | Subscribe to new nodes that can forward requests. |

## Mesh DNS Client Configurations

| CLI Flag | Config File | Default | Description |
| -------- | ----------- | ------- | ----------- |
| `--bridge.use-meshdns` | `bridge.use-meshdns` | `false` | Use the meshdns server for local name resolution. |

## Mesh Configurations

| CLI Flag | Config File | Default | Description |
| -------- | ----------- | ------- | ----------- |
| `--bridge.<mesh-id>.mesh.disable-feature-advertisement` | `bridge.<mesh-id>.mesh.disable-feature-advertisement` | `false` | Disable feature advertisement. |
| `--bridge.<mesh-id>.mesh.disable-ipv4` | `bridge.<mesh-id>.mesh.disable-ipv4` | `false` | Disable IPv4 usage. |
| `--bridge.<mesh-id>.mesh.disable-ipv6` | `bridge.<mesh-id>.mesh.disable-ipv6` | `false` | Disable IPv6 usage. |
| `--bridge.<mesh-id>.mesh.grpc-advertise-port` | `bridge.<mesh-id>.mesh.grpc-advertise-port` | `8443` | Port to advertise for gRPC. |
| `--bridge.<mesh-id>.mesh.ice-peers` | `bridge.<mesh-id>.mesh.ice-peers` | `[]` | Peers to request direct edges to over ICE. |
| `--bridge.<mesh-id>.mesh.join-address` | `bridge.<mesh-id>.mesh.join-address` |  | Address of a node to join. |
| `--bridge.<mesh-id>.mesh.libp2p-peers` | `bridge.<mesh-id>.mesh.libp2p-peers` | `[]` | Map of peer IDs to rendezvous strings for edges over libp2p. |
| `--bridge.<mesh-id>.mesh.max-join-retries` | `bridge.<mesh-id>.mesh.max-join-retries` | `15` | Maximum number of join retries. |
| `--bridge.<mesh-id>.mesh.meshdns-advertise-port` | `bridge.<mesh-id>.mesh.meshdns-advertise-port` | `53` | Port to advertise for DNS. |
| `--bridge.<mesh-id>.mesh.node-id` | `bridge.<mesh-id>.mesh.node-id` |  | Node ID. One will be chosen automatically if left unset. |
| `--bridge.<mesh-id>.mesh.primary-endpoint` | `bridge.<mesh-id>.mesh.primary-endpoint` |  | Primary endpoint to advertise when joining. |
| `--bridge.<mesh-id>.mesh.request-observer` | `bridge.<mesh-id>.mesh.request-observer` | `false` | Request to be an observer in the storage backend. |
| `--bridge.<mesh-id>.mesh.request-vote` | `bridge.<mesh-id>.mesh.request-vote` | `false` | Request a vote in elections for the storage backend. |
| `--bridge.<mesh-id>.mesh.routes` | `bridge.<mesh-id>.mesh.routes` | `[]` | Additional routes to advertise to the mesh. |
| `--bridge.<mesh-id>.mesh.storage-prefer-ipv6` | `bridge.<mesh-id>.mesh.storage-prefer-ipv6` | `false` | Prefer IPv6 connections for the storage backend transport. |
| `--bridge.<mesh-id>.mesh.use-meshdns` | `bridge.<mesh-id>.mesh.use-meshdns` | `false` | Set mesh DNS servers to the system configuration. |
| `--bridge.<mesh-id>.mesh.zone-awareness-id` | `bridge.<mesh-id>.mesh.zone-awareness-id` |  | Zone awareness ID. |

## Auth Configurations

| CLI Flag | Config File | Default | Description |
| -------- | ----------- | ------- | ----------- |
| `--bridge.<mesh-id>.auth.basic.password` | `bridge.<mesh-id>.auth.basic.password` |  | Basic auth password. |
| `--bridge.<mesh-id>.auth.basic.username` | `bridge.<mesh-id>.auth.basic.username` |  | Basic auth username. |
| `--bridge.<mesh-id>.auth.ldap.password` | `bridge.<mesh-id>.auth.ldap.password` |  | LDAP auth password. |
| `--bridge.<mesh-id>.auth.ldap.username` | `bridge.<mesh-id>.auth.ldap.username` |  | LDAP auth username. |
| `--bridge.<mesh-id>.auth.mtls.cert-data` | `bridge.<mesh-id>.auth.mtls.cert-data` |  | Base64 encoded TLS certificate data to present when joining. |
| `--bridge.<mesh-id>.auth.mtls.cert-file` | `bridge.<mesh-id>.auth.mtls.cert-file` |  | Path to a TLS certificate file to present when joining. |
| `--bridge.<mesh-id>.auth.mtls.key-data` | `bridge.<mesh-id>.auth.mtls.key-data` |  | Base64 encoded TLS key data for the certificate. |
| `--bridge.<mesh-id>.auth.mtls.key-file` | `bridge.<mesh-id>.auth.mtls.key-file` |  | Path to a TLS key file for the certificate. |

_TODO: Generic flags need to be provided for external plugin auth providers_

## Bootstrap Configurations

| CLI Flag | Config File | Default | Description |
| -------- | ----------- | ------- | ----------- |
| `--bridge.<mesh-id>.bootstrap.admin` | `bridge.<mesh-id>.bootstrap.admin` | `admin` | User and/or node name to assign administrator privileges to when bootstraping a new cluster |
| `--bridge.<mesh-id>.bootstrap.default-network-policy` | `bridge.<mesh-id>.bootstrap.default-network-policy` | `accept` | Default network policy to apply to the mesh when bootstraping a new cluster |
| `--bridge.<mesh-id>.bootstrap.disable-rbac` | `bridge.<mesh-id>.bootstrap.disable-rbac` | `false` | Disable RBAC when bootstrapping a new cluster |
| `--bridge.<mesh-id>.bootstrap.election-timeout` | `bridge.<mesh-id>.bootstrap.election-timeout` | `3s` | Election timeout to use when bootstrapping a new cluster |
| `--bridge.<mesh-id>.bootstrap.enabled` | `bridge.<mesh-id>.bootstrap.enabled` | `false` | Attempt to bootstrap a new cluster |
| `--bridge.<mesh-id>.bootstrap.force` | `bridge.<mesh-id>.bootstrap.force` | `false` | Force new bootstrap |
| `--bridge.<mesh-id>.bootstrap.ipv4-network` | `bridge.<mesh-id>.bootstrap.ipv4-network` | `172.16.0.0/12` | IPv4 network of the mesh to write to the database when bootstraping a new cluster |
| `--bridge.<mesh-id>.bootstrap.mesh-domain` | `bridge.<mesh-id>.bootstrap.mesh-domain` | `webmesh.internal` | Domain of the mesh to write to the database when bootstraping a new cluster |
| `--bridge.<mesh-id>.bootstrap.transport.psk` | `bridge.<mesh-id>.bootstrap.transport.psk` |  | Pre-shared key to use when using libp2p to bootstrap |
| `--bridge.<mesh-id>.bootstrap.transport.rendezvous` | `bridge.<mesh-id>.bootstrap.transport.rendezvous` |  | Rendezvous string to use when using libp2p to bootstrap |
| `--bridge.<mesh-id>.bootstrap.transport.rendezvous-linger` | `bridge.<mesh-id>.bootstrap.transport.rendezvous-linger` | `1m0s` | Amount of time to wait for other nodes to join when using libp2p to bootstrap |
| `--bridge.<mesh-id>.bootstrap.transport.rendezvous-nodes` | `bridge.<mesh-id>.bootstrap.transport.rendezvous-nodes` | `[]` | List of node IDs to use when using libp2p to bootstrap |
| `--bridge.<mesh-id>.bootstrap.transport.server-grpc-ports` | `bridge.<mesh-id>.bootstrap.transport.server-grpc-ports` | `[]` | Map of node IDs to gRPC ports to bootstrap with |
| `--bridge.<mesh-id>.bootstrap.transport.tcp-advertise-address` | `bridge.<mesh-id>.bootstrap.transport.tcp-advertise-address` |  | Address to advertise for raft consensus |
| `--bridge.<mesh-id>.bootstrap.transport.tcp-connect-timeout` | `bridge.<mesh-id>.bootstrap.transport.tcp-connect-timeout` | `3s` | Maximum amount of time to wait for a TCP connection to be established |
| `--bridge.<mesh-id>.bootstrap.transport.tcp-connection-pool` | `bridge.<mesh-id>.bootstrap.transport.tcp-connection-pool` | `0` | Maximum number of TCP connections to maintain to other nodes |
| `--bridge.<mesh-id>.bootstrap.transport.tcp-listen-address` | `bridge.<mesh-id>.bootstrap.transport.tcp-listen-address` | `[::]:9001` | Address to use when using TCP raft consensus to bootstrap |
| `--bridge.<mesh-id>.bootstrap.transport.tcp-servers` | `bridge.<mesh-id>.bootstrap.transport.tcp-servers` | `[]` | Map of node IDs to raft addresses to bootstrap with |
| `--bridge.<mesh-id>.bootstrap.voters` | `bridge.<mesh-id>.bootstrap.voters` | `[]` | Comma separated list of node IDs to assign voting privileges to when bootstraping a new cluster |

## Storage Configurations

| CLI Flag | Config File | Default | Description |
| -------- | ----------- | ------- | ----------- |
| `--bridge.<mesh-id>.storage.in-memory` | `bridge.<mesh-id>.storage.in-memory` | `false` | Use in-memory storage |
| `--bridge.<mesh-id>.storage.log-format` | `bridge.<mesh-id>.storage.log-format` | `text` | Log format for the storage provider |
| `--bridge.<mesh-id>.storage.log-level` | `bridge.<mesh-id>.storage.log-level` | `info` | Log level for the storage provider |
| `--bridge.<mesh-id>.storage.path` | `bridge.<mesh-id>.storage.path` | `/var/lib/webmesh/store` | Path to the storage directory |
| `--bridge.<mesh-id>.storage.provider` | `bridge.<mesh-id>.storage.provider` | `raft` | Storage provider (defaults to raftstorage or passthrough depending on other options) |

### Raft Storage Configurations

| CLI Flag | Config File | Default | Description |
| -------- | ----------- | ------- | ----------- |
| `--bridge.<mesh-id>.storage.raft.apply-timeout` | `bridge.<mesh-id>.storage.raft.apply-timeout` | `10s` | Raft apply timeout. |
| `--bridge.<mesh-id>.storage.raft.commit-timeout` | `bridge.<mesh-id>.storage.raft.commit-timeout` | `10s` | Raft commit timeout. |
| `--bridge.<mesh-id>.storage.raft.connection-pool-count` | `bridge.<mesh-id>.storage.raft.connection-pool-count` | `0` | Raft connection pool count. |
| `--bridge.<mesh-id>.storage.raft.connection-timeout` | `bridge.<mesh-id>.storage.raft.connection-timeout` | `3s` | Raft connection timeout. |
| `--bridge.<mesh-id>.storage.raft.election-timeout` | `bridge.<mesh-id>.storage.raft.election-timeout` | `2s` | Raft election timeout. |
| `--bridge.<mesh-id>.storage.raft.heartbeat-purge-threshold` | `bridge.<mesh-id>.storage.raft.heartbeat-purge-threshold` | `25` | Raft heartbeat purge threshold. |
| `--bridge.<mesh-id>.storage.raft.heartbeat-timeout` | `bridge.<mesh-id>.storage.raft.heartbeat-timeout` | `2s` | Raft heartbeat timeout. |
| `--bridge.<mesh-id>.storage.raft.leader-lease-timeout` | `bridge.<mesh-id>.storage.raft.leader-lease-timeout` | `2s` | Raft leader lease timeout. |
| `--bridge.<mesh-id>.storage.raft.listen-address` | `bridge.<mesh-id>.storage.raft.listen-address` | `[::]:9000` | Raft listen address. |
| `--bridge.<mesh-id>.storage.raft.max-append-entries` | `bridge.<mesh-id>.storage.raft.max-append-entries` | `64` | Raft max append entries. |
| `--bridge.<mesh-id>.storage.raft.observer-chan-buffer` | `bridge.<mesh-id>.storage.raft.observer-chan-buffer` | `100` | Raft observer channel buffer. |
| `--bridge.<mesh-id>.storage.raft.snapshot-interval` | `bridge.<mesh-id>.storage.raft.snapshot-interval` | `30s` | Raft snapshot interval. |
| `--bridge.<mesh-id>.storage.raft.snapshot-retention` | `bridge.<mesh-id>.storage.raft.snapshot-retention` | `2` | Raft snapshot retention. |
| `--bridge.<mesh-id>.storage.raft.snapshot-threshold` | `bridge.<mesh-id>.storage.raft.snapshot-threshold` | `8192` | Raft snapshot threshold. |

### External Storage Configurations

| CLI Flag | Config File | Default | Description |
| -------- | ----------- | ------- | ----------- |
| `--bridge.<mesh-id>.storage.external.config` | `bridge.<mesh-id>.storage.external.config` | `{}` | Configuration to pass to the plugin as key value pairs |
| `--bridge.<mesh-id>.storage.external.insecure` | `bridge.<mesh-id>.storage.external.insecure` | `false` | Use an insecure connection to the plugin server |
| `--bridge.<mesh-id>.storage.external.server` | `bridge.<mesh-id>.storage.external.server` |  | Address of a server for the plugin |
| `--bridge.<mesh-id>.storage.external.tls-ca-file` | `bridge.<mesh-id>.storage.external.tls-ca-file` |  | Path to a CA for verifying certificates |
| `--bridge.<mesh-id>.storage.external.tls-cert-file` | `bridge.<mesh-id>.storage.external.tls-cert-file` |  | Path to a certificate for authenticating to the plugin server |
| `--bridge.<mesh-id>.storage.external.tls-key-file` | `bridge.<mesh-id>.storage.external.tls-key-file` |  | Path to a key for authenticating to the plugin server |
| `--bridge.<mesh-id>.storage.external.tls-skip-verify` | `bridge.<mesh-id>.storage.external.tls-skip-verify` | `false` | Skip verifying the plugin server's certificate |

## TLS Configurations

| CLI Flag | Config File | Default | Description |
| -------- | ----------- | ------- | ----------- |
| `--bridge.<mesh-id>.tls.ca-data` | `bridge.<mesh-id>.tls.ca-data` |  | Base64 encoded TLS CA certificate for verifying peer certificates. |
| `--bridge.<mesh-id>.tls.ca-file` | `bridge.<mesh-id>.tls.ca-file` |  | Path to a TLS CA certificate for verifying peer certificates. |
| `--bridge.<mesh-id>.tls.insecure` | `bridge.<mesh-id>.tls.insecure` | `false` | Disable TLS. |
| `--bridge.<mesh-id>.tls.insecure-skip-verify` | `bridge.<mesh-id>.tls.insecure-skip-verify` | `false` | Skip verification of the server TLS cert. |
| `--bridge.<mesh-id>.tls.verify-chain-only` | `bridge.<mesh-id>.tls.verify-chain-only` | `false` | Verify only the certificate chain. |

## WireGuard Configurations

| CLI Flag | Config File | Default | Description |
| -------- | ----------- | ------- | ----------- |
| `--bridge.<mesh-id>.wireguard.endpoints` | `bridge.<mesh-id>.wireguard.endpoints` | `[]` | Additional WireGuard endpoints to broadcast when joining. |
| `--bridge.<mesh-id>.wireguard.force-interface-name` | `bridge.<mesh-id>.wireguard.force-interface-name` | `false` | Force the use of the given name by deleting any pre-existing interface with the same name. |
| `--bridge.<mesh-id>.wireguard.force-tun` | `bridge.<mesh-id>.wireguard.force-tun` | `false` | Force the use of a TUN interface. |
| `--bridge.<mesh-id>.wireguard.interface-name` | `bridge.<mesh-id>.wireguard.interface-name` | `webmesh0` | The name of the interface. |
| `--bridge.<mesh-id>.wireguard.key-file` | `bridge.<mesh-id>.wireguard.key-file` |  | The path to the WireGuard private key. If it does not exist it will be created. |
| `--bridge.<mesh-id>.wireguard.key-rotation-interval` | `bridge.<mesh-id>.wireguard.key-rotation-interval` | `168h0m0s` | The interval to rotate wireguard keys. Set this to 0 to disable key rotation. |
| `--bridge.<mesh-id>.wireguard.listen-port` | `bridge.<mesh-id>.wireguard.listen-port` | `51820` | The port to listen on. |
| `--bridge.<mesh-id>.wireguard.masquerade` | `bridge.<mesh-id>.wireguard.masquerade` | `false` | Enable masquerading of traffic from the wireguard interface. |
| `--bridge.<mesh-id>.wireguard.modprobe` | `bridge.<mesh-id>.wireguard.modprobe` | `false` | Attempt to load the wireguard kernel module on linux systems. |
| `--bridge.<mesh-id>.wireguard.mtu` | `bridge.<mesh-id>.wireguard.mtu` | `1420` | The MTU to use for the interface. |
| `--bridge.<mesh-id>.wireguard.persistent-keepalive` | `bridge.<mesh-id>.wireguard.persistent-keepalive` | `0s` | The interval at which to send keepalive packets to peers. |
| `--bridge.<mesh-id>.wireguard.record-metrics` | `bridge.<mesh-id>.wireguard.record-metrics` | `false` | Record WireGuard metrics. These are only exposed if the metrics server is enabled. |
| `--bridge.<mesh-id>.wireguard.record-metrics-interval` | `bridge.<mesh-id>.wireguard.record-metrics-interval` | `10s` | The interval at which to update WireGuard metrics. |

## Discovery Configurations

| CLI Flag | Config File | Default | Description |
| -------- | ----------- | ------- | ----------- |
| `--bridge.<mesh-id>.discovery.announce` | `bridge.<mesh-id>.discovery.announce` | `false` | announce this peer to the discovery service |
| `--bridge.<mesh-id>.discovery.announce-ttl` | `bridge.<mesh-id>.discovery.announce-ttl` | `1m0s` | TTL for the announcement |
| `--bridge.<mesh-id>.discovery.bootstrap-servers` | `bridge.<mesh-id>.discovery.bootstrap-servers` | `[]` | list of bootstrap servers to use for the DHT |
| `--bridge.<mesh-id>.discovery.connect-timeout` | `bridge.<mesh-id>.discovery.connect-timeout` | `5s` | timeout for connecting to a peer |
| `--bridge.<mesh-id>.discovery.discover` | `bridge.<mesh-id>.discovery.discover` | `false` | use the libp2p kademlia DHT for discovery |
| `--bridge.<mesh-id>.discovery.local-addrs` | `bridge.<mesh-id>.discovery.local-addrs` | `[]` | list of local addresses to announce to the discovery service |
| `--bridge.<mesh-id>.discovery.rendezvous` | `bridge.<mesh-id>.discovery.rendezvous` |  | pre-shared key to use as a rendezvous point for peer discovery |

## Services Configurations

| CLI Flag | Config File | Default | Description |
| -------- | ----------- | ------- | ----------- |
| `--bridge.<mesh-id>.services.api.admin-enabled` | `bridge.<mesh-id>.services.api.admin-enabled` | `false` | Enable and register the AdminAPI. |
| `--bridge.<mesh-id>.services.api.default-ipam-static-ipv4` | `bridge.<mesh-id>.services.api.default-ipam-static-ipv4` | `[]` | Static IPv4 assignments to use for the default IPAM. |
| `--bridge.<mesh-id>.services.api.disable-default-ipam` | `bridge.<mesh-id>.services.api.disable-default-ipam` | `false` | Disable the default IPAM. |
| `--bridge.<mesh-id>.services.api.disable-leader-proxy` | `bridge.<mesh-id>.services.api.disable-leader-proxy` | `false` | Disable the leader proxy. |
| `--bridge.<mesh-id>.services.api.disabled` | `bridge.<mesh-id>.services.api.disabled` | `false` | Disable the API. This is ignored when joining as a Raft member. |
| `--bridge.<mesh-id>.services.api.insecure` | `bridge.<mesh-id>.services.api.insecure` | `false` | Disable TLS. |
| `--bridge.<mesh-id>.services.api.listen-address` | `bridge.<mesh-id>.services.api.listen-address` | `[::]:8443` | gRPC listen address. |
| `--bridge.<mesh-id>.services.api.mesh-enabled` | `bridge.<mesh-id>.services.api.mesh-enabled` | `false` | Enable and register the MeshAPI. |
| `--bridge.<mesh-id>.services.api.tls-cert-data` | `bridge.<mesh-id>.services.api.tls-cert-data` |  | TLS certificate data. |
| `--bridge.<mesh-id>.services.api.tls-cert-file` | `bridge.<mesh-id>.services.api.tls-cert-file` |  | TLS certificate file. |
| `--bridge.<mesh-id>.services.api.tls-key-data` | `bridge.<mesh-id>.services.api.tls-key-data` |  | TLS key data. |
| `--bridge.<mesh-id>.services.api.tls-key-file` | `bridge.<mesh-id>.services.api.tls-key-file` |  | TLS key file. |
| `--bridge.<mesh-id>.services.api.web-enabled` | `bridge.<mesh-id>.services.api.web-enabled` | `false` | Enable gRPC over HTTP/1.1. |
| `--bridge.<mesh-id>.services.metrics.enabled` | `bridge.<mesh-id>.services.metrics.enabled` | `false` | Enable gRPC metrics. |
| `--bridge.<mesh-id>.services.metrics.listen-address` | `bridge.<mesh-id>.services.metrics.listen-address` | `[::]:8080` | gRPC metrics listen address. |
| `--bridge.<mesh-id>.services.metrics.path` | `bridge.<mesh-id>.services.metrics.path` | `/metrics` | gRPC metrics path. |
| `--bridge.<mesh-id>.services.turn.enabled` | `bridge.<mesh-id>.services.turn.enabled` | `false` | Enable TURN server. |
| `--bridge.<mesh-id>.services.turn.endpoint` | `bridge.<mesh-id>.services.turn.endpoint` |  | TURN endpoint to advertise. |
| `--bridge.<mesh-id>.services.turn.listen-address` | `bridge.<mesh-id>.services.turn.listen-address` | `[::]:3478` | Address to listen on for STUN/TURN requests. |
| `--bridge.<mesh-id>.services.turn.port-range` | `bridge.<mesh-id>.services.turn.port-range` | `49152-65535` | Port range to use for TURN relays. |
| `--bridge.<mesh-id>.services.turn.public-ip` | `bridge.<mesh-id>.services.turn.public-ip` |  | Public IP to advertise for STUN/TURN requests. |
| `--bridge.<mesh-id>.services.turn.realm` | `bridge.<mesh-id>.services.turn.realm` | `webmesh` | Realm used for TURN server authentication. |
| `--bridge.<mesh-id>.services.webrtc.enabled` | `bridge.<mesh-id>.services.webrtc.enabled` | `false` | Enable and register the WebRTC API. |
| `--bridge.<mesh-id>.services.webrtc.stun-servers` | `bridge.<mesh-id>.services.webrtc.stun-servers` | `[stun:stun.l.google.com:19302]` | TURN/STUN servers to use for the WebRTC API. |

## Plugin Configurations

| CLI Flag | Config File | Default | Description |
| -------- | ----------- | ------- | ----------- |
| `--bridge.<mesh-id>.plugins.basic-auth.htpasswd-file` | `bridge.<mesh-id>.plugins.basic-auth.htpasswd-file` |  | path to htpasswd file |
| `--bridge.<mesh-id>.plugins.debug.disable-pprof` | `bridge.<mesh-id>.plugins.debug.disable-pprof` | `false` | Disable pprof |
| `--bridge.<mesh-id>.plugins.debug.enable-db-querier` | `bridge.<mesh-id>.plugins.debug.enable-db-querier` | `false` | Enable database querier |
| `--bridge.<mesh-id>.plugins.debug.listen-address` | `bridge.<mesh-id>.plugins.debug.listen-address` | `localhost:6060` | Address to lissten on |
| `--bridge.<mesh-id>.plugins.debug.path-prefix` | `bridge.<mesh-id>.plugins.debug.path-prefix` | `/debug` | Path prefix to use for the debug server |
| `--bridge.<mesh-id>.plugins.debug.pprof-profiles` | `bridge.<mesh-id>.plugins.debug.pprof-profiles` |  | Pprof profiles to enable (default: all) |
| `--bridge.<mesh-id>.plugins.ldap.bind-dn` | `bridge.<mesh-id>.plugins.ldap.bind-dn` |  | DN to bind with |
| `--bridge.<mesh-id>.plugins.ldap.bind-password` | `bridge.<mesh-id>.plugins.ldap.bind-password` |  | Password to bind with |
| `--bridge.<mesh-id>.plugins.ldap.ca-file` | `bridge.<mesh-id>.plugins.ldap.ca-file` |  | Path to CA file to use to verify the LDAP server's certificate |
| `--bridge.<mesh-id>.plugins.ldap.node-id-attribute` | `bridge.<mesh-id>.plugins.ldap.node-id-attribute` |  | Attribute to use to identify the node |
| `--bridge.<mesh-id>.plugins.ldap.server` | `bridge.<mesh-id>.plugins.ldap.server` |  | LDAP server to connect to |
| `--bridge.<mesh-id>.plugins.ldap.user-base-dn` | `bridge.<mesh-id>.plugins.ldap.user-base-dn` |  | Base DN to use to search for users |
| `--bridge.<mesh-id>.plugins.ldap.user-disabled-value` | `bridge.<mesh-id>.plugins.ldap.user-disabled-value` |  | Value of the user status attribute that indicates the user is disabled |
| `--bridge.<mesh-id>.plugins.ldap.user-id-attribute` | `bridge.<mesh-id>.plugins.ldap.user-id-attribute` |  | Attribute to use to identify the user |
| `--bridge.<mesh-id>.plugins.ldap.user-status-attribute` | `bridge.<mesh-id>.plugins.ldap.user-status-attribute` |  | Attribute to use to determine if the user is disabled |
| `--bridge.<mesh-id>.plugins.mtls.ca-file` | `bridge.<mesh-id>.plugins.mtls.ca-file` |  | Path to a CA file to use to verify client certificates. |

