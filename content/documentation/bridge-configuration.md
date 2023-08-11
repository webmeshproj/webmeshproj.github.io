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

## Mesh DNS Server Configurations

| CLI Flag | Config File | Default | Description |
| -------- | ----------- | ------- | ----------- |
| `--bridge.services.meshdns.cache-size` | `bridge.services.meshdns.cache-size` | `0` | Size of the remote DNS cache. Defaults to 0 (disabled). |
| `--bridge.services.meshdns.disable-forwarding` | `bridge.services.meshdns.disable-forwarding` | `false` | Disable forwarding requests entirely. Takes precedence over other forwarding configurations. |
| `--bridge.services.meshdns.enable-compression` | `bridge.services.meshdns.enable-compression` | `true` | Enable DNS compression for mesh DNS. |
| `--bridge.services.meshdns.enabled` | `bridge.services.meshdns.enabled` | `false` | Enable mesh DNS. |
| `--bridge.services.meshdns.forwarders` | `bridge.services.meshdns.forwarders` |  | DNS forwarders to use for mesh DNS. If empty, the system DNS servers will be used. |
| `--bridge.services.meshdns.listen-tcp` | `bridge.services.meshdns.listen-tcp` | `:53` | TCP address to listen on for DNS requests. |
| `--bridge.services.meshdns.listen-udp` | `bridge.services.meshdns.listen-udp` | `:53` | UDP address to listen on for DNS requests. |
| `--bridge.services.meshdns.request-timeout` | `bridge.services.meshdns.request-timeout` | `5s` | Timeout for mesh DNS requests. |
| `--bridge.services.meshdns.reuse-port` | `bridge.services.meshdns.reuse-port` | `0` | Enable SO_REUSEPORT for mesh DNS. |
| `--bridge.services.meshdns.subscribe-forwarders` | `bridge.services.meshdns.subscribe-forwarders` | `false` | Subscribe to new nodes that are able to forward requests for other meshes.  These forwarders will be placed at the bottom of the forwarders list. |

## Mesh DNS Client Configurations

| CLI Flag | Config File | Default | Description |
| -------- | ----------- | ------- | ----------- |
| `--bridge.use-meshdns` | `bridge.use-meshdns` | `false` | use the meshdns server for system DNS |

## Mesh Configurations

| CLI Flag | Config File | Default | Description |
| -------- | ----------- | ------- | ----------- |
| `--bridge.<mesh-id>.mesh.direct-peers` | `bridge.<mesh-id>.mesh.direct-peers` |  | Comma separated list of peers to request direct edges to. 	If the node is not allowed to create edges and data channels, the node will be unable to join. |
| `--bridge.<mesh-id>.mesh.grpc-advertise-port` | `bridge.<mesh-id>.mesh.grpc-advertise-port` | `8443` | GRPC advertise port. |
| `--bridge.<mesh-id>.mesh.heartbeat-purge-threshold` | `bridge.<mesh-id>.mesh.heartbeat-purge-threshold` | `0` | Threshold of failed heartbeats for purging a peer. Default is 0 (disabled). |
| `--bridge.<mesh-id>.mesh.join-address` | `bridge.<mesh-id>.mesh.join-address` |  | Address of a node to join. |
| `--bridge.<mesh-id>.mesh.join-as-voter` | `bridge.<mesh-id>.mesh.join-as-voter` | `false` | Join the cluster as a voter. Default behavior is to join as an observer. |
| `--bridge.<mesh-id>.mesh.max-join-retries` | `bridge.<mesh-id>.mesh.max-join-retries` | `10` | Maximum number of join retries. |
| `--bridge.<mesh-id>.mesh.meshdns-advertise-port` | `bridge.<mesh-id>.mesh.meshdns-advertise-port` | `0` | DNS advertise port. This is set automatically when advertising is enabled and the mesh-dns server is running. Default is 0 (disabled). |
| `--bridge.<mesh-id>.mesh.no-ipv4` | `bridge.<mesh-id>.mesh.no-ipv4` | `false` | Do not request IPv4 assignments when joining. |
| `--bridge.<mesh-id>.mesh.no-ipv6` | `bridge.<mesh-id>.mesh.no-ipv6` | `false` | Do not request IPv6 assignments when joining. |
| `--bridge.<mesh-id>.mesh.node-id` | `bridge.<mesh-id>.mesh.node-id` | `<hostname>` | Store node ID. If not set, the ID comes from the following decision tree. 1. If mTLS is enabled, the node ID is the CN of the client certificate. 2. If mTLS is not enabled, the node ID is the hostname of the machine. 3. If the hostname is not available, the node ID is a random UUID (should only be used for testing). |
| `--bridge.<mesh-id>.mesh.peer-discovery-addresses` | `bridge.<mesh-id>.mesh.peer-discovery-addresses` |  | Addresses to use for peer discovery. |
| `--bridge.<mesh-id>.mesh.primary-endpoint` | `bridge.<mesh-id>.mesh.primary-endpoint` |  | The primary endpoint to broadcast when joining a cluster. This is only necessary if the node intends on being publicly accessible. |
| `--bridge.<mesh-id>.mesh.routes` | `bridge.<mesh-id>.mesh.routes` |  | Comma separated list of additional routes to advertise to the mesh. 	These routes are advertised to all peers. If the node is not allowed 	to put routes in the mesh, the node will be unable to join. |
| `--bridge.<mesh-id>.mesh.use-meshdns` | `bridge.<mesh-id>.mesh.use-meshdns` | `false` | Set mesh DNS servers to the system configuration. If a local server is running, this will use the local server. |
| `--bridge.<mesh-id>.mesh.zone-awareness-id` | `bridge.<mesh-id>.mesh.zone-awareness-id` |  | Zone awareness ID. If set, the server will prioritize peer endpoints in the same zone. |

## Auth Configurations

| CLI Flag | Config File | Default | Description |
| -------- | ----------- | ------- | ----------- |
| `--bridge.<mesh-id>.auth.basic.password` | `bridge.<mesh-id>.auth.basic.password` |  | A password to use for basic auth. |
| `--bridge.<mesh-id>.auth.basic.username` | `bridge.<mesh-id>.auth.basic.username` |  | A username to use for basic auth. |
| `--bridge.<mesh-id>.auth.ldap.password` | `bridge.<mesh-id>.auth.ldap.password` |  | A password to use for LDAP auth. |
| `--bridge.<mesh-id>.auth.ldap.username` | `bridge.<mesh-id>.auth.ldap.username` |  | A username to use for LDAP auth. |
| `--bridge.<mesh-id>.auth.mtls.cert-file` | `bridge.<mesh-id>.auth.mtls.cert-file` |  | The path to a TLS certificate file to present when joining. |
| `--bridge.<mesh-id>.auth.mtls.key-file` | `bridge.<mesh-id>.auth.mtls.key-file` |  | The path to a TLS key file for the certificate. |

_TODO: Generic flags need to be provided for external plugin auth providers_

## Bootstrap Configurations

| CLI Flag | Config File | Default | Description |
| -------- | ----------- | ------- | ----------- |
| `--bridge.<mesh-id>.bootstrap.admin` | `bridge.<mesh-id>.bootstrap.admin` | `admin` | Admin username to bootstrap the cluster with. |
| `--bridge.<mesh-id>.bootstrap.advertise-address` | `bridge.<mesh-id>.bootstrap.advertise-address` |  | Raft advertise address. Required when bootstrapping a new cluster, but will be replaced with the WireGuard address after bootstrapping. |
| `--bridge.<mesh-id>.bootstrap.default-network-policy` | `bridge.<mesh-id>.bootstrap.default-network-policy` | `deny` | Default network policy to bootstrap the cluster with. |
| `--bridge.<mesh-id>.bootstrap.enabled` | `bridge.<mesh-id>.bootstrap.enabled` | `false` | Bootstrap the cluster. |
| `--bridge.<mesh-id>.bootstrap.force` | `bridge.<mesh-id>.bootstrap.force` | `false` | Force bootstrapping a new cluster even if data is present. |
| `--bridge.<mesh-id>.bootstrap.ipv4-network` | `bridge.<mesh-id>.bootstrap.ipv4-network` | `172.16.0.0/12` | IPv4 network of the mesh to write to the database when bootstraping a new cluster. |
| `--bridge.<mesh-id>.bootstrap.mesh-domain` | `bridge.<mesh-id>.bootstrap.mesh-domain` | `webmesh.internal` | Domain of the mesh to write to the database when bootstraping a new cluster. |
| `--bridge.<mesh-id>.bootstrap.restore-snapshot` | `bridge.<mesh-id>.bootstrap.restore-snapshot` |  | Path to a snapshot to restore from when bootstrapping a new cluster. |
| `--bridge.<mesh-id>.bootstrap.servers` | `bridge.<mesh-id>.bootstrap.servers` |  | Comma separated list of servers to bootstrap with. This is only used if bootstrap is true. 	If empty, the node will use the advertise address as the bootstrap server. If not empty, 	all nodes in the list should be started with the same list configurations. If any are  	different then the first node to become leader will pick them. This can cause bootstrap 	to fail when using ACLs. Servers should be in the form of `<node-id>`=`<address>` where  	address is the raft advertise address. |
| `--bridge.<mesh-id>.bootstrap.servers-grpc-ports` | `bridge.<mesh-id>.bootstrap.servers-grpc-ports` |  | Comma separated list of gRPC ports to bootstrap with. This is only used if bootstrap is true. If empty, the node will use the advertise address and locally configured gRPC port for every node in bootstrap-servers. Ports should be in the form of `<node-id>`=`<port>`. |
| `--bridge.<mesh-id>.bootstrap.voters` | `bridge.<mesh-id>.bootstrap.voters` |  | Comma separated list of voters to bootstrap the cluster with. bootstrap-servers are already included in this list. |

## Raft Configurations

| CLI Flag | Config File | Default | Description |
| -------- | ----------- | ------- | ----------- |
| `--bridge.<mesh-id>.raft.apply-timeout` | `bridge.<mesh-id>.raft.apply-timeout` | `15s` | Raft apply timeout. |
| `--bridge.<mesh-id>.raft.commit-timeout` | `bridge.<mesh-id>.raft.commit-timeout` | `15s` | Raft commit timeout. |
| `--bridge.<mesh-id>.raft.connection-pool-count` | `bridge.<mesh-id>.raft.connection-pool-count` | `0` | Raft connection pool count. |
| `--bridge.<mesh-id>.raft.connection-timeout` | `bridge.<mesh-id>.raft.connection-timeout` | `3s` | Raft connection timeout. |
| `--bridge.<mesh-id>.raft.data-dir` | `bridge.<mesh-id>.raft.data-dir` | `/var/lib/webmesh/store` | Store data directory. |
| `--bridge.<mesh-id>.raft.election-timeout` | `bridge.<mesh-id>.raft.election-timeout` | `3s` | Raft election timeout. |
| `--bridge.<mesh-id>.raft.heartbeat-timeout` | `bridge.<mesh-id>.raft.heartbeat-timeout` | `3s` | Raft heartbeat timeout. |
| `--bridge.<mesh-id>.raft.in-memory` | `bridge.<mesh-id>.raft.in-memory` | `false` | Store data in memory. This should only be used for testing and ephemeral nodes. |
| `--bridge.<mesh-id>.raft.leader-lease-timeout` | `bridge.<mesh-id>.raft.leader-lease-timeout` | `3s` | Raft leader lease timeout. |
| `--bridge.<mesh-id>.raft.leave-on-shutdown` | `bridge.<mesh-id>.raft.leave-on-shutdown` | `false` | Leave the cluster when the server shuts down. |
| `--bridge.<mesh-id>.raft.listen-address` | `bridge.<mesh-id>.raft.listen-address` | `[::]:9443` | Raft listen address. |
| `--bridge.<mesh-id>.raft.log-level` | `bridge.<mesh-id>.raft.log-level` | `info` | Raft log level. |
| `--bridge.<mesh-id>.raft.max-append-entries` | `bridge.<mesh-id>.raft.max-append-entries` | `15` | Raft max append entries. |
| `--bridge.<mesh-id>.raft.observer-chan-buffer` | `bridge.<mesh-id>.raft.observer-chan-buffer` | `100` | Raft observer channel buffer size. |
| `--bridge.<mesh-id>.raft.prefer-ipv6` | `bridge.<mesh-id>.raft.prefer-ipv6` | `false` | Prefer IPv6 when connecting to raft peers. |
| `--bridge.<mesh-id>.raft.snapshot-interval` | `bridge.<mesh-id>.raft.snapshot-interval` | `3m0s` | Raft snapshot interval. |
| `--bridge.<mesh-id>.raft.snapshot-retention` | `bridge.<mesh-id>.raft.snapshot-retention` | `3` | Raft snapshot retention. |
| `--bridge.<mesh-id>.raft.snapshot-threshold` | `bridge.<mesh-id>.raft.snapshot-threshold` | `5` | Raft snapshot threshold. |

## TLS Configurations

| CLI Flag | Config File | Default | Description |
| -------- | ----------- | ------- | ----------- |
| `--bridge.<mesh-id>.tls.ca-file` | `bridge.<mesh-id>.tls.ca-file` |  | Path to a TLS CA certificate for verifying peer certificates. |
| `--bridge.<mesh-id>.tls.insecure` | `bridge.<mesh-id>.tls.insecure` | `false` | Don't use TLS for peer communication. |
| `--bridge.<mesh-id>.tls.insecure-skip-verify` | `bridge.<mesh-id>.tls.insecure-skip-verify` | `false` | Skip verification of peer certificates. |
| `--bridge.<mesh-id>.tls.verify-chain-only` | `bridge.<mesh-id>.tls.verify-chain-only` | `false` | Only verify the certificate chain of peer certificates. |

## WireGuard Configurations

| CLI Flag | Config File | Default | Description |
| -------- | ----------- | ------- | ----------- |
| `--bridge.<mesh-id>.wireguard.endpoints` | `bridge.<mesh-id>.wireguard.endpoints` |  | Comma separated list of additional WireGuard endpoints to broadcast when joining a cluster. |
| `--bridge.<mesh-id>.wireguard.force-interface-name` | `bridge.<mesh-id>.wireguard.force-interface-name` | `false` | Force the use of the given name by deleting any pre-existing interface with the same name. |
| `--bridge.<mesh-id>.wireguard.force-tun` | `bridge.<mesh-id>.wireguard.force-tun` | `false` | Force the use of a TUN interface. |
| `--bridge.<mesh-id>.wireguard.interface-name` | `bridge.<mesh-id>.wireguard.interface-name` | `<iface-name>` | The WireGuard interface name. |
| `--bridge.<mesh-id>.wireguard.key-file` | `bridge.<mesh-id>.wireguard.key-file` |  | The path to the WireGuard private key. If it does not exist it will be created. |
| `--bridge.<mesh-id>.wireguard.key-rotation-interval` | `bridge.<mesh-id>.wireguard.key-rotation-interval` | `168h0m0s` | Interval to rotate WireGuard keys. Set this to 0 to disable key rotation. |
| `--bridge.<mesh-id>.wireguard.listen-port` | `bridge.<mesh-id>.wireguard.listen-port` | `51820` | The WireGuard listen port. |
| `--bridge.<mesh-id>.wireguard.masquerade` | `bridge.<mesh-id>.wireguard.masquerade` | `false` | Masquerade traffic from the WireGuard interface. |
| `--bridge.<mesh-id>.wireguard.modprobe` | `bridge.<mesh-id>.wireguard.modprobe` | `false` | Attempt to load the WireGuard kernel module. |
| `--bridge.<mesh-id>.wireguard.mtu` | `bridge.<mesh-id>.wireguard.mtu` | `1350` | The MTU to use for the interface. |
| `--bridge.<mesh-id>.wireguard.persistent-keepalive` | `bridge.<mesh-id>.wireguard.persistent-keepalive` | `0s` | PersistentKeepAlive is the interval at which to send keepalive packets to peers. If unset, keepalive packets will automatically be sent to publicly accessible peers when this instance is behind a NAT. Otherwise, no keep-alive packets are sent. |
| `--bridge.<mesh-id>.wireguard.record-metrics` | `bridge.<mesh-id>.wireguard.record-metrics` | `false` | Publish WireGuard metrics. |
| `--bridge.<mesh-id>.wireguard.record-metrics-interval` | `bridge.<mesh-id>.wireguard.record-metrics-interval` | `15s` | Interval at which to update WireGuard metrics. |

## Services Configurations

| CLI Flag | Config File | Default | Description |
| -------- | ----------- | ------- | ----------- |
| `--bridge.<mesh-id>.services.api.admin` | `bridge.<mesh-id>.services.api.admin` | `false` | Enable the admin API. |
| `--bridge.<mesh-id>.services.api.disable-leader-proxy` | `bridge.<mesh-id>.services.api.disable-leader-proxy` | `false` | Disable the leader proxy. |
| `--bridge.<mesh-id>.services.api.mesh` | `bridge.<mesh-id>.services.api.mesh` | `false` | Enable the mesh API. |
| `--bridge.<mesh-id>.services.api.peer-discovery` | `bridge.<mesh-id>.services.api.peer-discovery` | `false` | Enable the peer discovery API. |
| `--bridge.<mesh-id>.services.api.stun-servers` | `bridge.<mesh-id>.services.api.stun-servers` | `stun:stun.l.google.com:19302` | STUN servers to use. |
| `--bridge.<mesh-id>.services.api.webrtc` | `bridge.<mesh-id>.services.api.webrtc` | `false` | Enable the WebRTC API. |
| `--bridge.<mesh-id>.services.campfire.enabled` | `bridge.<mesh-id>.services.campfire.enabled` | `false` | whether the campfire service is enabled |
| `--bridge.<mesh-id>.services.campfire.listen-udp` | `bridge.<mesh-id>.services.campfire.listen-udp` | `:4095` | the UDP address to listen on |
| `--bridge.<mesh-id>.services.dashboard.enabled` | `bridge.<mesh-id>.services.dashboard.enabled` | `false` | Enable the web dashboard. |
| `--bridge.<mesh-id>.services.dashboard.listen-address` | `bridge.<mesh-id>.services.dashboard.listen-address` | `:8080` | The address for the dashboard to listen on. |
| `--bridge.<mesh-id>.services.dashboard.prefix` | `bridge.<mesh-id>.services.dashboard.prefix` |  | The path prefix to use for the dashboard. |
| `--bridge.<mesh-id>.services.dashboard.tls-cert-file` | `bridge.<mesh-id>.services.dashboard.tls-cert-file` |  | The path to a certificate file to use for TLS. |
| `--bridge.<mesh-id>.services.dashboard.tls-key-file` | `bridge.<mesh-id>.services.dashboard.tls-key-file` |  | The path to a key file to use for TLS. |
| `--bridge.<mesh-id>.services.insecure` | `bridge.<mesh-id>.services.insecure` | `false` | Don't use TLS for the gRPC server. |
| `--bridge.<mesh-id>.services.listen-address` | `bridge.<mesh-id>.services.listen-address` | `[::]:8443` | gRPC server listen address. |
| `--bridge.<mesh-id>.services.metrics.enabled` | `bridge.<mesh-id>.services.metrics.enabled` | `false` | Enable gRPC metrics. |
| `--bridge.<mesh-id>.services.metrics.listen-address` | `bridge.<mesh-id>.services.metrics.listen-address` | `:8000` | gRPC metrics listen address. |
| `--bridge.<mesh-id>.services.metrics.path` | `bridge.<mesh-id>.services.metrics.path` | `/metrics` | gRPC metrics path. |
| `--bridge.<mesh-id>.services.tls-cert-file` | `bridge.<mesh-id>.services.tls-cert-file` |  | gRPC server TLS certificate file. |
| `--bridge.<mesh-id>.services.tls-key-file` | `bridge.<mesh-id>.services.tls-key-file` |  | gRPC server TLS key file. |
| `--bridge.<mesh-id>.services.turn.enabled` | `bridge.<mesh-id>.services.turn.enabled` | `false` | Enable the TURN server. |
| `--bridge.<mesh-id>.services.turn.endpoint` | `bridge.<mesh-id>.services.turn.endpoint` |  | The TURN server endpoint. If empty, the public IP will be used. |
| `--bridge.<mesh-id>.services.turn.listen-address` | `bridge.<mesh-id>.services.turn.listen-address` | `0.0.0.0` | Address to listen on for TURN connections. |
| `--bridge.<mesh-id>.services.turn.listen-port` | `bridge.<mesh-id>.services.turn.listen-port` | `3478` | Port to listen on for TURN connections. |
| `--bridge.<mesh-id>.services.turn.public-ip` | `bridge.<mesh-id>.services.turn.public-ip` |  | The address advertised for STUN requests. |
| `--bridge.<mesh-id>.services.turn.server-realm` | `bridge.<mesh-id>.services.turn.server-realm` | `webmesh.io` | Realm used for TURN server authentication. |
| `--bridge.<mesh-id>.services.turn.stun-port-range` | `bridge.<mesh-id>.services.turn.stun-port-range` | `49152-65535` | Port range to use for STUN. |

## Plugin Configurations

| CLI Flag | Config File | Default | Description |
| -------- | ----------- | ------- | ----------- |
| `--bridge.<mesh-id>.plugins.basic-auth.htpasswd-file` | `bridge.<mesh-id>.plugins.basic-auth.htpasswd-file` |  | Enables the basic auth plugin with the path to a htpasswd file |
| `--bridge.<mesh-id>.plugins.debug.disable-pprof` | `bridge.<mesh-id>.plugins.debug.disable-pprof` |  | Enables the debug plugin with pprof disabled |
| `--bridge.<mesh-id>.plugins.debug.enable-db-querier` | `bridge.<mesh-id>.plugins.debug.enable-db-querier` |  | Enables the debug plugin with the database querier enabled |
| `--bridge.<mesh-id>.plugins.debug.listen-address` | `bridge.<mesh-id>.plugins.debug.listen-address` |  | Enables the debug plugin with the listen address |
| `--bridge.<mesh-id>.plugins.debug.path-prefix` | `bridge.<mesh-id>.plugins.debug.path-prefix` |  | Enables the debug plugin with the path prefix |
| `--bridge.<mesh-id>.plugins.debug.pprof-profiles` | `bridge.<mesh-id>.plugins.debug.pprof-profiles` |  | Enables the debug plugin with the pprof profiles |
| `--bridge.<mesh-id>.plugins.ipam.static-ipv4` | `bridge.<mesh-id>.plugins.ipam.static-ipv4` |  | Adds the given static IPv4 address(es) to the IPAM plugin. In the format of `<node_id>`=`<cidr_prefix>` |
| `--bridge.<mesh-id>.plugins.ipam.static-ipv6` | `bridge.<mesh-id>.plugins.ipam.static-ipv6` |  | Adds the given static IPv6 address(es) to the IPAM plugin In the format of `<node-_id>`=`<cidr_prefix>` |
| `--bridge.<mesh-id>.plugins.ldap.bind-dn` | `bridge.<mesh-id>.plugins.ldap.bind-dn` |  | Enables the ldap plugin with the bind DN |
| `--bridge.<mesh-id>.plugins.ldap.bind-password` | `bridge.<mesh-id>.plugins.ldap.bind-password` |  | Enables the ldap plugin with the bind password |
| `--bridge.<mesh-id>.plugins.ldap.ca-file` | `bridge.<mesh-id>.plugins.ldap.ca-file` |  | Enables the ldap plugin with the path to a CA for verifying certificates |
| `--bridge.<mesh-id>.plugins.ldap.node-id-attribute` | `bridge.<mesh-id>.plugins.ldap.node-id-attribute` |  | Enables the ldap plugin with the node ID attribute |
| `--bridge.<mesh-id>.plugins.ldap.server` | `bridge.<mesh-id>.plugins.ldap.server` |  | Enables the ldap plugin with the server address |
| `--bridge.<mesh-id>.plugins.ldap.user-base-dn` | `bridge.<mesh-id>.plugins.ldap.user-base-dn` |  | Enables the ldap plugin with the user base DN |
| `--bridge.<mesh-id>.plugins.ldap.user-disabled-value` | `bridge.<mesh-id>.plugins.ldap.user-disabled-value` |  | Enables the ldap plugin with the user disabled value |
| `--bridge.<mesh-id>.plugins.ldap.user-id-attribute` | `bridge.<mesh-id>.plugins.ldap.user-id-attribute` |  | Enables the ldap plugin with the user ID attribute |
| `--bridge.<mesh-id>.plugins.ldap.user-status-attribute` | `bridge.<mesh-id>.plugins.ldap.user-status-attribute` |  | Enables the ldap plugin with the user status attribute |
| `--bridge.<mesh-id>.plugins.local` | `bridge.<mesh-id>.plugins.local` |  | A configuration for a local executable plugin. Provided in the format of `<path=/path/to/executable,config1=val1,config2=val2,...>` |
| `--bridge.<mesh-id>.plugins.mtls.ca-file` | `bridge.<mesh-id>.plugins.mtls.ca-file` |  | Enables the mTLS plugin with the path to a CA for verifying certificates |
| `--bridge.<mesh-id>.plugins.server` | `bridge.<mesh-id>.plugins.server` |  | A configuration for a remote server plugin. Configurations are the same as the local plugin, but with the addition of server configurations in the format of: `<server=rpcserver.com:8443[,insecure=true][,tls-ca-file=ca.crt][,tls-key-file=tls.key][,tls-cert-file=tls.crt]>` |

