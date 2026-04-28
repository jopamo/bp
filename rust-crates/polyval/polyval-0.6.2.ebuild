# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="polyval"
CRATE_VERSION="0.6.2"
CRATE_CHECKSUM="9d1fe60d06143b2430aa532c94cfe9e29783047f06c0d7fd359a9a51b729fa25"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="POLYVAL is a GHASH-like universal hash over GF(2^128) useful for constructing a Message Authentication Code (MAC)"
HOMEPAGE="https://github.com/RustCrypto/universal-hashes"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"std"
)
