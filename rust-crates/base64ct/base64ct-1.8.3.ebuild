# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="base64ct"
CRATE_VERSION="1.8.3"
CRATE_CHECKSUM="2af50177e190e07a26ab74f8b1efbfe2ef87da2116221318cb1c2e82baf7de06"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of Base64 (RFC 4648) which avoids any usages of data-dependent branches/LUTs and thereby provides portable \"best effort\" constant-time operation and embedded-friendly no_std support"
HOMEPAGE="https://github.com/RustCrypto/formats/tree/master/base64ct"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"std"
)
