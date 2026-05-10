# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rkyv"
CRATE_VERSION="0.8.14"
CRATE_CHECKSUM="360b333c61ae24e5af3ae7c8660bd6b21ccd8200dbbc5d33c2454421e85b9c69"
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
	"hashbrown-0_16"
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
