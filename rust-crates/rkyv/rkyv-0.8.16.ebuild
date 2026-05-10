# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rkyv"
CRATE_VERSION="0.8.16"
CRATE_CHECKSUM="73389e0c99e664f919275ab5b5b0471391fe9a8de61e1dff9b1eaf56a90f16e3"
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
	"hashbrown-0_17"
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
