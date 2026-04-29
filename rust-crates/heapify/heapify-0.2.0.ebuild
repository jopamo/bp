# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="heapify"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="0049b265b7f201ca9ab25475b22b47fe444060126a51abe00f77d986fc5cc52e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Convenience functions to turn slices into max-heaps."
HOMEPAGE="https://github.com/ethereal-sheep/heapify"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
