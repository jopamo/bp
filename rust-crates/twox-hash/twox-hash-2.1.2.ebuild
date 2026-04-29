# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="twox-hash"
CRATE_VERSION="2.1.2"
CRATE_CHECKSUM="9ea3136b675547379c4bd395ca6b938e5ad3c3d20fad76e7fe85f9e0d011419c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust implementation of the XXHash and XXH3 algorithms"
HOMEPAGE="https://github.com/shepmaster/twox-hash"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"random"
	"serialize"
	"std"
	"xxhash32"
	"xxhash3_128"
	"xxhash3_64"
	"xxhash64"
)
