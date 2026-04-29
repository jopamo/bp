# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="derive_builder"
CRATE_VERSION="0.20.2"
CRATE_CHECKSUM="507dfb09ea8b7fa618fcf76e953f4f5e192547945816d5358edffe39f6f94947"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust macro to automatically implement the builder pattern for arbitrary structs."
HOMEPAGE="https://github.com/colin-kiegel/rust-derive-builder"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"clippy"
	"default"
	"std"
)
