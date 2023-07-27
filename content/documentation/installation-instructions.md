---
title: Installation
weight: -13
---

This page outlines the various methods of installing the Webmesh project.

_Note: Verifying `cosign` signatures requires at least version `2.0.0` of the `cosign` binary._

{{< toc >}}

## Docker

The Webmesh project is distributed as a container image for Linux hosts.
These images will also work on Docker Desktop for Mac and Windows, but are not supported for production use on those platforms.
Each image is signed with ephemeral `cosign` keys using the Github container registry and OIDC provider.

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

## System Packages

The packages below all install the following two binaries:

- `webmesh-node`: The Webmesh node binary
- `wmctl`: A CLI for interacting with the Webmesh node

### Verifying Signature and Checksums

A `checksums.txt` file is available for each release on the [releases page](https://github.com/webmeshproj/node/releases/latest).
A corresponding `cosign` signature of the file is available as `checksums.txt.sig`.
The certificate used to sign the file is available as `checksums.txt.sig.cert`.

If you'd like to verify the signature, you can use the following commands.
This is highly recommended until published packages are signed with a GPG key or native package managers support `cosign` signatures.

```bash
# Change this to a specific release version if you'd like
DOWNLOAD_URL="https://github.com/webmeshproj/node/releases/latest/download"
# Download the checksums file
curl -JLO ${DOWNLOAD_URL}/checksums.txt
# Verify the signature against the checksums file
export COSIGN_EXPERIMENTAL=true
cosign verify-blob \
    --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
    --certificate-identity-regexp="github\.com/webmeshproj/node" \
    --signature="${DOWNLOAD_URL}/checksums.txt.sig" \
    --certificate="${DOWNLOAD_URL}/checksums.txt.sig.cert" \
    checksums.txt

# Download release assets you'd like to verify
# ...
# ...

# Verify the checksums file against any downloaded release assets
# Arguments may be different depending on your platform
sha256sum -c checksums.txt --ignore-missing
```

### macOS

#### Homebrew

```bash
# Tap and install
brew tap webmeshproj/repo
brew install webmesh

# Or all in one
brew install webmeshproj/repo/webmesh
```

#### Standalone

```bash
# Change this to a specific release version if you'd like
DOWNLOAD_URL="https://github.com/webmeshproj/node/releases/latest/download"
ARCH=$(uname -m)

# Download the release tarball
curl -JLO ${DOWNLOAD_URL}/webmesh_Darwin_${ARCH}.tar.gz

# Unpack the tarball into /usr/local/bin
sudo tar -C /usr/local/bin -xzf webmesh_Darwin_${ARCH}.tar.gz webmesh-node wmctl
# Remove the tarball
rm webmesh_Darwin_${ARCH}.tar.gz
```

### Linux

#### Debian/Ubuntu

Install the latest `deb` package from the releases page.

```bash
# Change this to a specific release version if you'd like
# Assumes you have jq and curl installed
VERSION=$(curl -L -s https://api.github.com/repos/webmeshproj/node/releases/latest | jq -r .name)
# You may need to change the architecture name depending on your platform
ARCH=$(uname -m)
if [ "${ARCH}" == "x86_64" ]; then
    ARCH="amd64"
elif [ "${ARCH}" == "aarch64" ]; then
    ARCH="arm64"
fi

# Download and install the package
curl -JLO https://github.com/webmeshproj/node/releases/download/${VERSION}/webmesh_${VERSION:1}_linux_${ARCH}.deb
sudo dpkg -i webmesh_${VERSION:1}_linux_${ARCH}.deb
```

#### RedHat/CentOS/Rocky Linux/Fedora

Install the latest `rpm` package from the releases page.

```bash
# Change this to a specific release version if you'd like
# Assumes you have jq and curl installed
VERSION=$(curl -L -s https://api.github.com/repos/webmeshproj/node/releases/latest | jq -r .name)
# You may need to change the architecture name depending on your platform
ARCH=$(uname -m)
if [ "${ARCH}" == "x86_64" ]; then
    ARCH="amd64"
elif [ "${ARCH}" == "aarch64" ]; then
    ARCH="arm64"
fi

# Install the extra repositories
dnf -y install epel-release elrepo-release

# Install the package
dnf -y install https://github.com/webmeshproj/node/releases/download/${VERSION}/webmesh_${VERSION:1}_linux_${ARCH}.rpm
```

#### Alpine

Install the latest `apk` package from the releases page.

```bash
# Change this to a specific release version if you'd like
# Assumes you have jq and curl installed
VERSION=$(curl -L -s https://api.github.com/repos/webmeshproj/node/releases/latest | jq -r .name)
# You may need to change the architecture name depending on your platform
ARCH=$(uname -m)
if [ "${ARCH}" == "x86_64" ]; then
    ARCH="amd64"
elif [ "${ARCH}" == "aarch64" ]; then
    ARCH="arm64"
fi

# Install the package
curl -JLO https://github.com/webmeshproj/node/releases/download/${VERSION}/webmesh_${VERSION:1}_linux_${ARCH}.apk
apk add --allow-untrusted webmesh_${VERSION:1}_linux_${ARCH}.apk
```

#### Arch

There is a `pacman` package available, but it is not yet signed with a GPG key.
For now, you can use one of the AUR packages:

- [webmesh-bin](https://aur.archlinux.org/packages/webmesh-bin): Latest pre-built release
- [webmesh-git](https://aur.archlinux.org/packages/webmesh-git): Builds from source (currently builds from `main` branch)

#### Standalone

Fetch the latest release tarball from the releases page.

```bash
# Change this to a specific release version if you'd like
DOWNLOAD_URL="https://github.com/webmeshproj/node/releases/latest/download"
ARCH=$(uname -m)

# Download the release tarball
curl -JLO ${DOWNLOAD_URL}/webmesh_Linux_${ARCH}.tar.gz

# Unpack the tarball into /usr/local/bin
sudo tar -C /usr/local/bin -xzf webmesh_Linux_${ARCH}.tar.gz webmesh-node wmctl
# Remove the tarball
rm webmesh_Linux_${ARCH}.tar.gz
```

### FreeBSD

The project supports FreeBSD, but compiling currently requires a FreeBSD build environment.
As such, we currently do not provide pre-built binaries for FreeBSD.

To build the project on FreeBSD, ensure you have `golang` installed and run:

```bash
git clone https://github.com/webmeshproj/node.git
cd node
# Build the webmesh node binary
CGO_ENABLED=1 go build -o webmesh-node ./cmd/node/main.go
# Build the wmctl binary
CGO_ENABLED=1 go build -o wmctl ./cmd/wmctl/main.go
```

This will be streamlined in the future.

### Windows

Windows support is not thoroughly tested, but the project should work on Windows 10 and Windows Server 2019+.
Better application packaging is planned for the future.

#### Standalone

Go to the [releases page](https://github.com/webmeshproj/node/releases/latest) and download the Windows `zip` package for your architecture.
Extract the `zip` file and add the `webmesh-node` and `wmctl` binaries to your `PATH`.

## Kubernetes

The prefered method for using Webmesh on Kubernetes is via the [operator](https://github.com/webmeshproj/operator).
More documentation will be available both here and in the operator repository soon.
