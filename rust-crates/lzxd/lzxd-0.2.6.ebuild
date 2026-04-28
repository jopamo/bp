# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="lzxd"
CRATE_VERSION="0.2.6"
CRATE_CHECKSUM="7b29dffab797218e12e4df08ef5d15ab9efca2504038b1b32b9b32fc844b39c9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Decompression implementation for Microsoft's LZXD compression format."
HOMEPAGE="https://github.com/Lonami/lzxd"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
