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

| CLI Flag | Env Var | Config File | Default | Description |
| -------- | ------- | ----------- | ------- | ----------- |
| `--global.allow-remote-detection` | `GLOBAL_ALLOW_REMOTE_DETECTION` | `global.allow-remote-detection` | `false` | Allow remote detection of endpoints. |
| `--global.detect-endpoints` | `GLOBAL_DETECT_ENDPOINTS` | `global.detect-endpoints` | `false` | Detect potential endpoints from the local interfaces. |
| `--global.detect-ipv6` | `GLOBAL_DETECT_IPV6` | `global.detect-ipv6` | `false` | Detect IPv6 addresses. Default is to only detect IPv4. |
| `--global.detect-private-endpoints` | `GLOBAL_DETECT_PRIVATE_ENDPOINTS` | `global.detect-private-endpoints` | `false` | Include private IP addresses in detection. |
| `--global.disable-feature-advertisement` | `GLOBAL_DISABLE_FEATURE_ADVERTISEMENT` | `global.disable-feature-advertisement` | `false` | Do not advertise features to the rest of the mesh. |
| `--global.insecure` | `GLOBAL_INSECURE` | `global.insecure` | `false` | Disable use of TLS globally. |
| `--global.log-level` | `GLOBAL_LOG_LEVEL` | `global.log-level` | `info` | Log level (debug, info, warn, error) |
| `--global.mtls` | `GLOBAL_MTLS` | `global.mtls` | `false` | Enable mutual TLS for authentication. |
| `--global.no-ipv4` | `GLOBAL_NO_IPV4` | `global.no-ipv4` | `false` | Disable use of IPv4 globally. |
| `--global.no-ipv6` | `GLOBAL_NO_IPV6` | `global.no-ipv6` | `false` | Disable use of IPv6 globally. |
| `--global.primary-endpoint` | `GLOBAL_PRIMARY_ENDPOINT` | `global.primary-endpoint` |  | The preferred publicly routable address of this node. Setting this value will override the address portion of the store advertise address.  When detect-endpoints is true, this value will be the first address detected. |
| `--global.tls-ca-file` | `GLOBAL_TLS_CA_FILE` | `global.tls-ca-file` |  | The CA file for TLS connections. |
| `--global.tls-cert-file` | `GLOBAL_TLS_CERT_FILE` | `global.tls-cert-file` |  | The certificate file for TLS connections. |
| `--global.tls-client-ca-file` | `GLOBAL_TLS_CLIENT_CA_FILE` | `global.tls-client-ca-file` |  | The client CA file for TLS connections. |
| `--global.tls-key-file` | `GLOBAL_TLS_KEY_FILE` | `global.tls-key-file` |  | The key file for TLS connections. |
| `--global.verify-chain-only` | `GLOBAL_VERIFY_CHAIN_ONLY` | `global.verify-chain-only` | `false` | Only verify the TLS chain globally. |

## Mesh Configurations

| CLI Flag | Env Var | Config File | Default | Description |
| -------- | ------- | ----------- | ------- | ----------- |
| `--mesh.direct-peers` | `MESH_DIRECT_PEERS` | `mesh.direct-peers` |  | Comma separated list of peers to request direct edges to. 	If the node is not allowed to create edges and data channels, the node will be unable to join. |
| `--mesh.grpc-advertise-port` | `MESH_GRPC_ADVERTISE_PORT` | `mesh.grpc-advertise-port` | `8443` | GRPC advertise port. |
| `--mesh.heartbeat-purge-threshold` | `MESH_HEARTBEAT_PURGE_THRESHOLD` | `mesh.heartbeat-purge-threshold` | `0` | Threshold of failed heartbeats for purging a peer. Default is 0 (disabled). |
| `--mesh.join-address` | `MESH_JOIN_ADDRESS` | `mesh.join-address` |  | Address of a node to join. |
| `--mesh.join-as-observer` | `MESH_JOIN_AS_OBSERVER` | `mesh.join-as-observer` | `false` | Join the cluster as a raft observer. |
| `--mesh.join-as-voter` | `MESH_JOIN_AS_VOTER` | `mesh.join-as-voter` | `false` | Join the cluster as a raft voter. |
| `--mesh.join-campfire-uri` | `MESH_JOIN_CAMPFIRE_URI` | `mesh.join-campfire-uri` |  | Campfire URI to use for joining. |
| `--mesh.max-join-retries` | `MESH_MAX_JOIN_RETRIES` | `mesh.max-join-retries` | `10` | Maximum number of join retries. |
| `--mesh.meshdns-advertise-port` | `MESH_MESHDNS_ADVERTISE_PORT` | `mesh.meshdns-advertise-port` | `0` | DNS advertise port. This is set automatically when advertising is enabled and the mesh-dns server is running. Default is 0 (disabled). |
| `--mesh.no-ipv4` | `MESH_NO_IPV4` | `mesh.no-ipv4` | `false` | Do not request IPv4 assignments when joining. |
| `--mesh.no-ipv6` | `MESH_NO_IPV6` | `mesh.no-ipv6` | `false` | Do not request IPv6 assignments when joining. |
| `--mesh.node-id` | `MESH_NODE_ID` | `mesh.node-id` | `<hostname>` | Store node ID. If not set, the ID comes from the following decision tree. 1. If mTLS is enabled, the node ID is the CN of the client certificate. 2. If mTLS is not enabled, the node ID is the hostname of the machine. 3. If the hostname is not available, the node ID is a random UUID (should only be used for testing). |
| `--mesh.peer-discovery-addresses` | `MESH_PEER_DISCOVERY_ADDRESSES` | `mesh.peer-discovery-addresses` |  | Addresses to use for peer discovery. |
| `--mesh.primary-endpoint` | `MESH_PRIMARY_ENDPOINT` | `mesh.primary-endpoint` |  | The primary endpoint to broadcast when joining a cluster. This is only necessary if the node intends on being publicly accessible. |
| `--mesh.routes` | `MESH_ROUTES` | `mesh.routes` |  | Comma separated list of additional routes to advertise to the mesh. 	These routes are advertised to all peers. If the node is not allowed 	to put routes in the mesh, the node will be unable to join. |
| `--mesh.use-meshdns` | `MESH_USE_MESHDNS` | `mesh.use-meshdns` | `false` | Set mesh DNS servers to the system configuration. If a local server is running, this will use the local server. |
| `--mesh.wait-campfire-uri` | `MESH_WAIT_CAMPFIRE_URI` | `mesh.wait-campfire-uri` |  | Campfire URI to allow others to join through. |
| `--mesh.zone-awareness-id` | `MESH_ZONE_AWARENESS_ID` | `mesh.zone-awareness-id` |  | Zone awareness ID. If set, the server will prioritize peer endpoints in the same zone. |

## Auth Configurations

| CLI Flag | Env Var | Config File | Default | Description |
| -------- | ------- | ----------- | ------- | ----------- |
| `--auth.basic.password` | `AUTH_BASIC_PASSWORD` | `auth.basic.password` |  | A password to use for basic auth. |
| `--auth.basic.username` | `AUTH_BASIC_USERNAME` | `auth.basic.username` |  | A username to use for basic auth. |
| `--auth.ldap.password` | `AUTH_LDAP_PASSWORD` | `auth.ldap.password` |  | A password to use for LDAP auth. |
| `--auth.ldap.username` | `AUTH_LDAP_USERNAME` | `auth.ldap.username` |  | A username to use for LDAP auth. |
| `--auth.mtls.cert-file` | `AUTH_MTLS_CERT_FILE` | `auth.mtls.cert-file` |  | The path to a TLS certificate file to present when joining. |
| `--auth.mtls.key-file` | `AUTH_MTLS_KEY_FILE` | `auth.mtls.key-file` |  | The path to a TLS key file for the certificate. |

_TODO: Generic flags need to be provided for external plugin auth providers_

## Bootstrap Configurations

| CLI Flag | Env Var | Config File | Default | Description |
| -------- | ------- | ----------- | ------- | ----------- |
| `--bootstrap.admin` | `BOOTSTRAP_ADMIN` | `bootstrap.admin` | `admin` | Admin username to bootstrap the cluster with. |
| `--bootstrap.advertise-address` | `BOOTSTRAP_ADVERTISE_ADDRESS` | `bootstrap.advertise-address` |  | Raft advertise address. Required when bootstrapping a new cluster, but will be replaced with the WireGuard address after bootstrapping. |
| `--bootstrap.default-network-policy` | `BOOTSTRAP_DEFAULT_NETWORK_POLICY` | `bootstrap.default-network-policy` | `deny` | Default network policy to bootstrap the cluster with. |
| `--bootstrap.enabled` | `BOOTSTRAP_ENABLED` | `bootstrap.enabled` | `false` | Bootstrap the cluster. |
| `--bootstrap.force` | `BOOTSTRAP_FORCE` | `bootstrap.force` | `false` | Force bootstrapping a new cluster even if data is present. |
| `--bootstrap.ipv4-network` | `BOOTSTRAP_IPV4_NETWORK` | `bootstrap.ipv4-network` | `172.16.0.0/12` | IPv4 network of the mesh to write to the database when bootstraping a new cluster. |
| `--bootstrap.mesh-domain` | `BOOTSTRAP_MESH_DOMAIN` | `bootstrap.mesh-domain` | `webmesh.internal` | Domain of the mesh to write to the database when bootstraping a new cluster. |
| `--bootstrap.servers` | `BOOTSTRAP_SERVERS` | `bootstrap.servers` |  | Comma separated list of servers to bootstrap with. This is only used if bootstrap is true. 	If empty, the node will use the advertise address as the bootstrap server. If not empty, 	all nodes in the list should be started with the same list configurations. If any are  	different then the first node to become leader will pick them. This can cause bootstrap 	to fail when using ACLs. Servers should be in the form of `<node-id>`=`<address>` where  	address is the raft advertise address. |
| `--bootstrap.servers-grpc-ports` | `BOOTSTRAP_SERVERS_GRPC_PORTS` | `bootstrap.servers-grpc-ports` |  | Comma separated list of gRPC ports to bootstrap with. This is only used if bootstrap is true. If empty, the node will use the advertise address and locally configured gRPC port for every node in bootstrap-servers. Ports should be in the form of `<node-id>`=`<port>`. |
| `--bootstrap.voters` | `BOOTSTRAP_VOTERS` | `bootstrap.voters` |  | Comma separated list of voters to bootstrap the cluster with. bootstrap-servers are already included in this list. |

## Raft Configurations

| CLI Flag | Env Var | Config File | Default | Description |
| -------- | ------- | ----------- | ------- | ----------- |
| `--raft.apply-timeout` | `RAFT_APPLY_TIMEOUT` | `raft.apply-timeout` | `15s` | Raft apply timeout. |
| `--raft.commit-timeout` | `RAFT_COMMIT_TIMEOUT` | `raft.commit-timeout` | `15s` | Raft commit timeout. |
| `--raft.connection-pool-count` | `RAFT_CONNECTION_POOL_COUNT` | `raft.connection-pool-count` | `0` | Raft connection pool count. |
| `--raft.connection-timeout` | `RAFT_CONNECTION_TIMEOUT` | `raft.connection-timeout` | `3s` | Raft connection timeout. |
| `--raft.data-dir` | `RAFT_DATA_DIR` | `raft.data-dir` | `/var/lib/webmesh/store` | Store data directory. |
| `--raft.election-timeout` | `RAFT_ELECTION_TIMEOUT` | `raft.election-timeout` | `3s` | Raft election timeout. |
| `--raft.heartbeat-timeout` | `RAFT_HEARTBEAT_TIMEOUT` | `raft.heartbeat-timeout` | `3s` | Raft heartbeat timeout. |
| `--raft.in-memory` | `RAFT_IN_MEMORY` | `raft.in-memory` | `false` | Store data in memory. This should only be used for testing and ephemeral nodes. |
| `--raft.leader-lease-timeout` | `RAFT_LEADER_LEASE_TIMEOUT` | `raft.leader-lease-timeout` | `3s` | Raft leader lease timeout. |
| `--raft.leave-on-shutdown` | `RAFT_LEAVE_ON_SHUTDOWN` | `raft.leave-on-shutdown` | `false` | Leave the cluster when the server shuts down. |
| `--raft.listen-address` | `RAFT_LISTEN_ADDRESS` | `raft.listen-address` | `[::]:9443` | Raft listen address. |
| `--raft.log-level` | `RAFT_LOG_LEVEL` | `raft.log-level` | `info` | Raft log level. |
| `--raft.max-append-entries` | `RAFT_MAX_APPEND_ENTRIES` | `raft.max-append-entries` | `15` | Raft max append entries. |
| `--raft.observer-chan-buffer` | `RAFT_OBSERVER_CHAN_BUFFER` | `raft.observer-chan-buffer` | `100` | Raft observer channel buffer size. |
| `--raft.prefer-ipv6` | `RAFT_PREFER_IPV6` | `raft.prefer-ipv6` | `false` | Prefer IPv6 when connecting to raft peers. |
| `--raft.snapshot-interval` | `RAFT_SNAPSHOT_INTERVAL` | `raft.snapshot-interval` | `3m0s` | Raft snapshot interval. |
| `--raft.snapshot-retention` | `RAFT_SNAPSHOT_RETENTION` | `raft.snapshot-retention` | `3` | Raft snapshot retention. |
| `--raft.snapshot-threshold` | `RAFT_SNAPSHOT_THRESHOLD` | `raft.snapshot-threshold` | `5` | Raft snapshot threshold. |

## TLS Configurations

| CLI Flag | Env Var | Config File | Default | Description |
| -------- | ------- | ----------- | ------- | ----------- |
| `--tls.ca-file` | `TLS_CA_FILE` | `tls.ca-file` |  | Path to a TLS CA certificate for verifying peer certificates. |
| `--tls.insecure` | `TLS_INSECURE` | `tls.insecure` | `false` | Don't use TLS for peer communication. |
| `--tls.insecure-skip-verify` | `TLS_INSECURE_SKIP_VERIFY` | `tls.insecure-skip-verify` | `false` | Skip verification of peer certificates. |
| `--tls.verify-chain-only` | `TLS_VERIFY_CHAIN_ONLY` | `tls.verify-chain-only` | `false` | Only verify the certificate chain of peer certificates. |

## WireGuard Configurations

| CLI Flag | Env Var | Config File | Default | Description |
| -------- | ------- | ----------- | ------- | ----------- |
| `--wireguard.endpoints` | `WIREGUARD_ENDPOINTS` | `wireguard.endpoints` |  | Comma separated list of additional WireGuard endpoints to broadcast when joining a cluster. |
| `--wireguard.force-interface-name` | `WIREGUARD_FORCE_INTERFACE_NAME` | `wireguard.force-interface-name` | `false` | Force the use of the given name by deleting any pre-existing interface with the same name. |
| `--wireguard.force-tun` | `WIREGUARD_FORCE_TUN` | `wireguard.force-tun` | `false` | Force the use of a TUN interface. |
| `--wireguard.interface-name` | `WIREGUARD_INTERFACE_NAME` | `wireguard.interface-name` |  | The WireGuard interface name. |
| `--wireguard.key-file` | `WIREGUARD_KEY_FILE` | `wireguard.key-file` |  | The path to the WireGuard private key. If it does not exist it will be created. |
| `--wireguard.key-rotation-interval` | `WIREGUARD_KEY_ROTATION_INTERVAL` | `wireguard.key-rotation-interval` | `168h0m0s` | Interval to rotate WireGuard keys. Set this to 0 to disable key rotation. |
| `--wireguard.listen-port` | `WIREGUARD_LISTEN_PORT` | `wireguard.listen-port` | `51820` | The WireGuard listen port. |
| `--wireguard.masquerade` | `WIREGUARD_MASQUERADE` | `wireguard.masquerade` | `false` | Masquerade traffic from the WireGuard interface. |
| `--wireguard.modprobe` | `WIREGUARD_MODPROBE` | `wireguard.modprobe` | `false` | Attempt to load the WireGuard kernel module. |
| `--wireguard.mtu` | `WIREGUARD_MTU` | `wireguard.mtu` | `1350` | The MTU to use for the interface. |
| `--wireguard.persistent-keepalive` | `WIREGUARD_PERSISTENT_KEEPALIVE` | `wireguard.persistent-keepalive` | `0s` | PersistentKeepAlive is the interval at which to send keepalive packets to peers. If unset, keepalive packets will automatically be sent to publicly accessible peers when this instance is behind a NAT. Otherwise, no keep-alive packets are sent. |
| `--wireguard.record-metrics` | `WIREGUARD_RECORD_METRICS` | `wireguard.record-metrics` | `false` | Publish WireGuard metrics. |
| `--wireguard.record-metrics-interval` | `WIREGUARD_RECORD_METRICS_INTERVAL` | `wireguard.record-metrics-interval` | `15s` | Interval at which to update WireGuard metrics. |

## Services Configurations

| CLI Flag | Env Var | Config File | Default | Description |
| -------- | ------- | ----------- | ------- | ----------- |
| `--services.api.admin` | `SERVICES_API_ADMIN` | `services.api.admin` | `false` | Enable the admin API. |
| `--services.api.disable-leader-proxy` | `SERVICES_API_DISABLE_LEADER_PROXY` | `services.api.disable-leader-proxy` | `false` | Disable the leader proxy. |
| `--services.api.mesh` | `SERVICES_API_MESH` | `services.api.mesh` | `false` | Enable the mesh API. |
| `--services.api.peer-discovery` | `SERVICES_API_PEER_DISCOVERY` | `services.api.peer-discovery` | `false` | Enable the peer discovery API. |
| `--services.api.stun-servers` | `SERVICES_API_STUN_SERVERS` | `services.api.stun-servers` | `stun:stun.l.google.com:19302` | STUN servers to use. |
| `--services.api.webrtc` | `SERVICES_API_WEBRTC` | `services.api.webrtc` | `false` | Enable the WebRTC API. |
| `--services.campfire.enabled` | `SERVICES_CAMPFIRE_ENABLED` | `services.campfire.enabled` | `false` | whether the campfire service is enabled |
| `--services.campfire.listen-udp` | `SERVICES_CAMPFIRE_LISTEN_UDP` | `services.campfire.listen-udp` | `:4095` | the UDP address to listen on |
| `--services.dashboard.enabled` | `SERVICES_DASHBOARD_ENABLED` | `services.dashboard.enabled` | `false` | Enable the web dashboard. |
| `--services.dashboard.listen-address` | `SERVICES_DASHBOARD_LISTEN_ADDRESS` | `services.dashboard.listen-address` | `:8080` | The address for the dashboard to listen on. |
| `--services.dashboard.prefix` | `SERVICES_DASHBOARD_PREFIX` | `services.dashboard.prefix` |  | The path prefix to use for the dashboard. |
| `--services.dashboard.tls-cert-file` | `SERVICES_DASHBOARD_TLS_CERT_FILE` | `services.dashboard.tls-cert-file` |  | The path to a certificate file to use for TLS. |
| `--services.dashboard.tls-key-file` | `SERVICES_DASHBOARD_TLS_KEY_FILE` | `services.dashboard.tls-key-file` |  | The path to a key file to use for TLS. |
| `--services.insecure` | `SERVICES_INSECURE` | `services.insecure` | `false` | Don't use TLS for the gRPC server. |
| `--services.listen-address` | `SERVICES_LISTEN_ADDRESS` | `services.listen-address` | `[::]:8443` | gRPC server listen address. |
| `--services.meshdns.cache-size` | `SERVICES_MESHDNS_CACHE_SIZE` | `services.meshdns.cache-size` | `0` | Size of the remote DNS cache. Defaults to 0 (disabled). |
| `--services.meshdns.disable-forwarding` | `SERVICES_MESHDNS_DISABLE_FORWARDING` | `services.meshdns.disable-forwarding` | `false` | Disable forwarding requests entirely. Takes precedence over other forwarding configurations. |
| `--services.meshdns.enable-compression` | `SERVICES_MESHDNS_ENABLE_COMPRESSION` | `services.meshdns.enable-compression` | `true` | Enable DNS compression for mesh DNS. |
| `--services.meshdns.enabled` | `SERVICES_MESHDNS_ENABLED` | `services.meshdns.enabled` | `false` | Enable mesh DNS. |
| `--services.meshdns.forwarders` | `SERVICES_MESHDNS_FORWARDERS` | `services.meshdns.forwarders` |  | DNS forwarders to use for mesh DNS. If empty, the system DNS servers will be used. |
| `--services.meshdns.listen-tcp` | `SERVICES_MESHDNS_LISTEN_TCP` | `services.meshdns.listen-tcp` | `:53` | TCP address to listen on for DNS requests. |
| `--services.meshdns.listen-udp` | `SERVICES_MESHDNS_LISTEN_UDP` | `services.meshdns.listen-udp` | `:53` | UDP address to listen on for DNS requests. |
| `--services.meshdns.request-timeout` | `SERVICES_MESHDNS_REQUEST_TIMEOUT` | `services.meshdns.request-timeout` | `5s` | Timeout for mesh DNS requests. |
| `--services.meshdns.reuse-port` | `SERVICES_MESHDNS_REUSE_PORT` | `services.meshdns.reuse-port` | `0` | Enable SO_REUSEPORT for mesh DNS. |
| `--services.meshdns.subscribe-forwarders` | `SERVICES_MESHDNS_SUBSCRIBE_FORWARDERS` | `services.meshdns.subscribe-forwarders` | `false` | Subscribe to new nodes that are able to forward requests for other meshes.  These forwarders will be placed at the bottom of the forwarders list. |
| `--services.metrics.enabled` | `SERVICES_METRICS_ENABLED` | `services.metrics.enabled` | `false` | Enable gRPC metrics. |
| `--services.metrics.listen-address` | `SERVICES_METRICS_LISTEN_ADDRESS` | `services.metrics.listen-address` | `:8000` | gRPC metrics listen address. |
| `--services.metrics.path` | `SERVICES_METRICS_PATH` | `services.metrics.path` | `/metrics` | gRPC metrics path. |
| `--services.tls-cert-file` | `SERVICES_TLS_CERT_FILE` | `services.tls-cert-file` |  | gRPC server TLS certificate file. |
| `--services.tls-key-file` | `SERVICES_TLS_KEY_FILE` | `services.tls-key-file` |  | gRPC server TLS key file. |
| `--services.turn.campfire-enabled` | `SERVICES_TURN_CAMPFIRE_ENABLED` | `services.turn.campfire-enabled` | `false` | Enable handling campfire packets on the TURN server. |
| `--services.turn.enabled` | `SERVICES_TURN_ENABLED` | `services.turn.enabled` | `false` | Enable the TURN server. |
| `--services.turn.endpoint` | `SERVICES_TURN_ENDPOINT` | `services.turn.endpoint` |  | The TURN server endpoint. If empty, the public IP will be used. |
| `--services.turn.listen-address` | `SERVICES_TURN_LISTEN_ADDRESS` | `services.turn.listen-address` | `0.0.0.0` | Address to listen on for TURN connections. |
| `--services.turn.listen-port` | `SERVICES_TURN_LISTEN_PORT` | `services.turn.listen-port` | `3478` | Port to listen on for TURN connections. |
| `--services.turn.public-ip` | `SERVICES_TURN_PUBLIC_IP` | `services.turn.public-ip` |  | The address advertised for STUN requests. |
| `--services.turn.server-realm` | `SERVICES_TURN_SERVER_REALM` | `services.turn.server-realm` | `webmesh.io` | Realm used for TURN server authentication. |
| `--services.turn.stun-port-range` | `SERVICES_TURN_STUN_PORT_RANGE` | `services.turn.stun-port-range` | `49152-65535` | Port range to use for STUN. |

## Plugin Configurations

| CLI Flag | Env Var | Config File | Default | Description |
| -------- | ------- | ----------- | ------- | ----------- |
| `--plugins.basic-auth.htpasswd-file` | `PLUGINS_BASIC_AUTH_HTPASSWD_FILE` | `plugins.basic-auth.htpasswd-file` |  | Enables the basic auth plugin with the path to a htpasswd file |
| `--plugins.debug.disable-pprof` | `PLUGINS_DEBUG_DISABLE_PPROF` | `plugins.debug.disable-pprof` |  | Enables the debug plugin with pprof disabled |
| `--plugins.debug.enable-db-querier` | `PLUGINS_DEBUG_ENABLE_DB_QUERIER` | `plugins.debug.enable-db-querier` |  | Enables the debug plugin with the database querier enabled |
| `--plugins.debug.listen-address` | `PLUGINS_DEBUG_LISTEN_ADDRESS` | `plugins.debug.listen-address` |  | Enables the debug plugin with the listen address |
| `--plugins.debug.path-prefix` | `PLUGINS_DEBUG_PATH_PREFIX` | `plugins.debug.path-prefix` |  | Enables the debug plugin with the path prefix |
| `--plugins.debug.pprof-profiles` | `PLUGINS_DEBUG_PPROF_PROFILES` | `plugins.debug.pprof-profiles` |  | Enables the debug plugin with the pprof profiles |
| `--plugins.ipam.static-ipv4` | `PLUGINS_IPAM_STATIC_IPV4` | `plugins.ipam.static-ipv4` |  | Adds the given static IPv4 address(es) to the IPAM plugin. In the format of `<node_id>`=`<cidr_prefix>` |
| `--plugins.ipam.static-ipv6` | `PLUGINS_IPAM_STATIC_IPV6` | `plugins.ipam.static-ipv6` |  | Adds the given static IPv6 address(es) to the IPAM plugin In the format of `<node-_id>`=`<cidr_prefix>` |
| `--plugins.ldap.bind-dn` | `PLUGINS_LDAP_BIND_DN` | `plugins.ldap.bind-dn` |  | Enables the ldap plugin with the bind DN |
| `--plugins.ldap.bind-password` | `PLUGINS_LDAP_BIND_PASSWORD` | `plugins.ldap.bind-password` |  | Enables the ldap plugin with the bind password |
| `--plugins.ldap.ca-file` | `PLUGINS_LDAP_CA_FILE` | `plugins.ldap.ca-file` |  | Enables the ldap plugin with the path to a CA for verifying certificates |
| `--plugins.ldap.node-id-attribute` | `PLUGINS_LDAP_NODE_ID_ATTRIBUTE` | `plugins.ldap.node-id-attribute` |  | Enables the ldap plugin with the node ID attribute |
| `--plugins.ldap.server` | `PLUGINS_LDAP_SERVER` | `plugins.ldap.server` |  | Enables the ldap plugin with the server address |
| `--plugins.ldap.user-base-dn` | `PLUGINS_LDAP_USER_BASE_DN` | `plugins.ldap.user-base-dn` |  | Enables the ldap plugin with the user base DN |
| `--plugins.ldap.user-disabled-value` | `PLUGINS_LDAP_USER_DISABLED_VALUE` | `plugins.ldap.user-disabled-value` |  | Enables the ldap plugin with the user disabled value |
| `--plugins.ldap.user-id-attribute` | `PLUGINS_LDAP_USER_ID_ATTRIBUTE` | `plugins.ldap.user-id-attribute` |  | Enables the ldap plugin with the user ID attribute |
| `--plugins.ldap.user-status-attribute` | `PLUGINS_LDAP_USER_STATUS_ATTRIBUTE` | `plugins.ldap.user-status-attribute` |  | Enables the ldap plugin with the user status attribute |
| `--plugins.local` | `PLUGINS_LOCAL` | `plugins.local` |  | A configuration for a local executable plugin. Provided in the format of `<path=/path/to/executable,config1=val1,config2=val2,...>` |
| `--plugins.mtls.ca-file` | `PLUGINS_MTLS_CA_FILE` | `plugins.mtls.ca-file` |  | Enables the mTLS plugin with the path to a CA for verifying certificates |
| `--plugins.server` | `PLUGINS_SERVER` | `plugins.server` |  | A configuration for a remote server plugin. Configurations are the same as the local plugin, but with the addition of server configurations in the format of: `<server=rpcserver.com:8443[,insecure=true][,tls-ca-file=ca.crt][,tls-key-file=tls.key][,tls-cert-file=tls.crt]>` |

