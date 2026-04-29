# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="derive_builder_core"
CRATE_VERSION="0.20.2"
CRATE_CHECKSUM="2d5bcf7b024d6835cfb3d473887cd966994907effbe9227e8c8219824d06c4e8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Internal helper library for the derive_builder crate."
HOMEPAGE="https://github.com/colin-kiegel/rust-derive-builder"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"clippy"
	"lib_has_std"
)
