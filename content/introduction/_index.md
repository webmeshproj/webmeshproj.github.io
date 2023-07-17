---
title: Introduction
weight: -30
---

# What is Webmesh?

[![Go Report Card](https://goreportcard.com/badge/github.com/webmeshproj/node)](https://goreportcard.com/report/github.com/webmeshproj/node)
![Build and Tests](https://github.com/webmeshproj/node/actions/workflows/ci.yaml/badge.svg)

Webmesh is a project that aims to provide a zero-configuration, simple, secure, and scalable way to connect devices and services across the internet.
It is inspired by several other projects that have emerged over the years such as TailScale, ZeroTier, and OpenZiti.
Peers connect to eachother either via other peers, a central controller (or combination of controllers), or direct links negotiated via WebRTC.

Nodes connected to the network take on one of three roles. They can be a client, a server, or both.
A client is a node that is connected to the network but does not provide any services, except to itself.
A server is a node that is connected to the network and provides services to other nodes.
When a server node is also the leader, it is referred to as a controller and facilitates requests to join the mesh or mutate state.
Other server nodes will proxy requests that require the leader appropriately.
State is maintained on every connected node via Raft consensus.
This allows for the network to be highly available and fault tolerant.

The network supports role-based access control and can be configured to allow or deny access to specific services and operations to specific nodes.
The same goes for network access controls.
This is the recommended way to run the network, but insecure options are provided for testing and development purposes.
The current supported authentication methods are:

- mTLS
- LDAP
- Basic Auth

The main implementation can be found in the [node](https://github.com/webmeshproj/node) repository.
Here you can find example configurations and more documentation on how to run the network.
