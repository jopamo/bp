# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="primeorder"
CRATE_VERSION="0.13.6"
CRATE_CHECKSUM="353e1ca18966c16d9deb1c69278edbc5f194139612772bd9537af60ac231e1e6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of complete addition formulas for prime order elliptic curves (Renes-Costello-Batina 2015). Generic over field elements and curve equation coefficients"
HOMEPAGE="https://github.com/RustCrypto/elliptic-curves/tree/master/primeorder"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"dev"
	"serde"
	"std"
)
