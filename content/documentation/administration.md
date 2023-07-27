---
title: Administration
weight: -5
---

The Webmesh project is designed to be as simple as possible to administer.
Almost all settings can be determined automatically, and the rest can be configured via the [Admin API](https://github.com/webmeshproj/api/blob/main/proto/v1/admin.proto) or CLI by a node or user with the proper credentials.

Until better documentation is in place, this document shows the usage of the CLI utility included in this repository.

## Configuring the CLI

The CLI uses a Kubernetes-link configuration syntax with options for command line flags and environment variables.
For now the structure of the configuration can be found in the source [here](https://github.com/webmeshproj/webmesh/blob/main/pkg/ctlcmd/config/config.go).
The default configuration is read from `~/.wmctl/config.yaml` and can be overridden with the `--config` flag or `WMCTL_CONFIG` environment variable.

An example configuration for a cluster using mTLS may look like this:

```yaml
apiVersion: webmesh.io/v1
kind: Config
clusters:
  - name: mesh-sample
    cluster:
      server: 172.19.0.2:8443
      tls-verify-chain-only: true
      certificate-authority-data: <redacted>
users:
  - name: mesh-sample-admin
    user:
      client-certificate-data: <redacted>
      client-key-data: <redacted>
contexts:
  - name: mesh-sample
    context:
      cluster: mesh-sample
      user: mesh-sample-admin
current-context: mesh-sample
```

CLI Usage can be found by running `wmctl --help`.
Generated documentation can be found [here](https://webmeshproj.github.io/cli/wmctl/).
