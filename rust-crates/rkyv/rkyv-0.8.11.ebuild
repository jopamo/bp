# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rkyv"
CRATE_VERSION="0.8.11"
CRATE_CHECKSUM="19f5c3e5da784cd8c69d32cdc84673f3204536ca56e1fa01be31a74b92c932ac"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Zero-copy deserialization framework for Rust"
HOMEPAGE="https://github.com/rkyv/rkyv"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"aligned"
	"alloc"
	"big_endian"
	"bytecheck"
	"default"
	"hashbrown-0_15"
	"indexmap-2"
	"little_endian"
	"pointer_width_16"
	"pointer_width_32"
	"pointer_width_64"
	"std"
	"triomphe-0_1"
	"unaligned"
	"uuid-1"
)
