---
title: Webmesh Project
geekdocNav: true
geekdocAlign: center
geekdocAnchor: false
---

Webmesh is a simple, distributed, zero-configuration WireGuard™ mesh provider for Linux, FreeBSD, macOS, and Windows.
It is designed to be easy to use, and to work well with existing network infrastructure.

{{< button size="large" relref="documentation/getting-started/" >}}Getting Started{{< /button >}}

## Feature overview

{{< columns >}}

### Zero Configuration

Quickly setup secure, zero-trust networks between your devices and users, without the hassle of manually configuring firewalls or VPNs.

<--->

### High Bandwidth

Utilizes native kernel support for WireGuard™ when available, falling back to the cross-platform userspace implementation otherwise.

<--->

### Pluggable Architecture

Uses a simple plugin architecture to enable additional features, such as third-party authentication backends.

{{< /columns >}}

{{< columns >}}

### Highly Available

Each connected device maintains a local copy of network state via Raft consensus. Any node can take on the role of controller.

<--->

### Simple Codebase

The code does not try to do too much, and is easy to audit. Functionality is deferred to the underlying operating system whenever possible.

<--->

### Open Source

Released under the Apache 2.0 license, and hosted on GitHub. Contributions are welcome!

{{< /columns >}}
