# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tokio-vsock"
CRATE_VERSION="0.7.1"
CRATE_CHECKSUM="1824fc0300433f400df6b6264a9ab00ba93f39d38c3157fb5f05183476c4af10"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Asynchronous Virtio socket support for Rust"
HOMEPAGE="https://github.com/rust-vsock/tokio-vsock"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
