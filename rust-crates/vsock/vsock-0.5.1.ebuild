# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="vsock"
CRATE_VERSION="0.5.1"
CRATE_CHECKSUM="4e8b4d00e672f147fc86a09738fadb1445bd1c0a40542378dfb82909deeee688"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Virtio socket support for Rust"
HOMEPAGE="https://github.com/rust-vsock/vsock-rs"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
