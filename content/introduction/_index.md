---
title: Introduction
weight: -30
---

# What is Webmesh?

Webmesh is a simple, distributed, and zero-configuration WireGuard™ mesh solution for Linux, FreeBSD, macOS, and Windows.
It allows for easily creating a mesh network between multiple hosts, and provides a simple API for managing the network.
It is designed to be easy to use, and to work well with existing network infrastructure.
The project aims to provide a zero-configuration, simple, secure, and scalable way to connect devices and services across the internet.
It allows for easily creating a mesh network between multiple hosts, and provides a simple API for managing the network.
It is inspired by several other projects that have emerged over the years such as TailScale, and ZeroTier.

Webmesh is not a VPN, but rather a mesh network.
It is designed to be used in conjunction with existing network infrastructure, and not as a replacement for it.
It is also not a replacement for WireGuard™, but rather a way to manage a WireGuard™ mesh network.
Connections are made into the network via direct links, over ICE (WebRTC) connections, or over LibP2P circuit relays.
It differs from other WireGuard™ management solutions in that:

- It is designed to be distributed and extensible, relying on no single controller or database.
- The network is malleable and topology is governed by the user, not the controller.
- A plugin API is provided for adding additional functionality, such as a distributed database for storing the mesh state or additional authentication mechanisms.
- An application API is also provided for interacting with the mesh network, and is used by the CLI and GUI applications.

Nodes connected to the network take on one of three roles. They can be a client, a server, or both.
A client is a node that is connected to the network but does not provide any services, except to itself.
A server is a node that is connected to the network and provides services to other nodes.
When a server node is also the leader, it is referred to as a controller and facilitates requests to join the mesh or mutate state.
Other server nodes will proxy requests that require the leader appropriately.

Nodes can become part of the raft consensus as either voters or observers.
As voters they will participate in the consensus and be able to become the leader.
As observers they will not participate in the consensus, but will have direct access to the state of the network locally.
When nodes are not part of the consensus, they use RPCs to communicate with those that are for state changes.
This allows for the network to be highly available and fault tolerant.

The network supports role-based access control and can be configured to allow or deny access to specific services to specific nodes.
The same goes for network access controls, however more work needs to be done in this space.
These are the recommended way to run the network, but insecure options are provided for testing and development purposes.
The current supported authentication methods are:

- mTLS (recommended)
- LDAP
- Basic Auth

The main source and packages can be found in the [webmesh](https://github.com/webmeshproj/webmesh) repository.
