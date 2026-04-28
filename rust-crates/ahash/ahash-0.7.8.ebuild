# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ahash"
CRATE_VERSION="0.7.8"
CRATE_CHECKSUM="891477e0c6a8957309ee5c45a6368af3ae14bb510732d2684ffa19af310920f9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A non-cryptographic hash function using AES-NI for high performance"
HOMEPAGE="https://github.com/tkaitchuck/ahash"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"atomic-polyfill"
	"compile-time-rng"
	"default"
	"std"
)
