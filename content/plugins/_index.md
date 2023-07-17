---
title: Plugins
weight: -10
---

Webmesh Plugins implement the [`v1.Plugin`](https://github.com/webmeshproj/api/blob/main/proto/v1/plugin.proto) interface and are loaded by the node at startup.
These can be run as external servers or as part of the node process.

Extended documentation will be added soon, but for now you can refer to the following areas to get started:

- [`pkg/plugins`](https://github.com/webmeshproj/node/tree/main/pkg/plugins) - The built-in plugins included with the node.
- [Localstore example](https://github.com/webmeshproj/node/tree/main/examples/localstore-plugin) - An example of running the node with a built-in plugin.
- [External plugin example](https://github.com/webmeshproj/node/tree/main/examples/remote-server-plugin) - An example of running the node with an external plugin.
