# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="base16ct"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="4c7f02d4ea65f2c1853089ffd8d2787bdbc63de2f0d29dedbcf8ccdfa0ccd4cf"
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
	"std"
)
