# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="base16ct"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="fd307490d624467aa6f74b0eabb77633d1f758a7b25f12bceb0b22e08d9726f6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of Base16 a.k.a hexadecimal (RFC 4648) which avoids any usages of data-dependent branches/LUTs and thereby provides portable \"best effort\" constant-time operation and embedded-friendly no_std support"
HOMEPAGE="https://github.com/RustCrypto/formats/tree/master/base16ct"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
)
