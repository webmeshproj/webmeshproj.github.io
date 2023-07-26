---
title: Installation
weight: -13
---

This page outlines the various methods of installing the Webmesh project.

_Note: Verifying `cosign` signatures requires at least version `2.0.0` of the `cosign` binary._

{{< toc >}}

## Docker

The Webmesh project is distributed as a container image.
Each image is signed with epehemeral `cosign` keys using the Github container registry and OIDC provider.

The image and signatures are available in the GitHub container registry at `ghcr.io/webmeshproj/node:latest`.
You can pull the image with:

```bash
docker pull ghcr.io/webmeshproj/node:latest
```

Images are also available for each release tag.
To verify the image with `cosign`, you can use the following command:

```bash
export COSIGN_EXPERIMENTAL=true
cosign verify --output=text \
    --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
    --certificate-identity-regexp="github\.com/webmeshproj/node" \
    ghcr.io/webmeshproj/node:latest
```
