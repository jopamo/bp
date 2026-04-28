# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="base64ct"
CRATE_VERSION="1.6.0"
CRATE_CHECKSUM="8c3c1a368f70d6cf7302d78f8f7093da241fb8e8807c05cc9e51a125895a6d5b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of Base64 (RFC 4648) which avoids any usages of data-dependent branches/LUTs and thereby provides portable \"best effort\" constant-time operation and embedded-friendly no_std support"
HOMEPAGE="https://github.com/RustCrypto/formats/tree/master/base64ct"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"std"
)
