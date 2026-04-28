# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="elliptic-curve"
CRATE_VERSION="0.13.8"
CRATE_CHECKSUM="b5e6043086bf7973472e0c7dff2142ea0b680d30e18d9cc40f267efbf222bd47"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="General purpose Elliptic Curve Cryptography (ECC) support, including types and traits for representing various elliptic curve forms, scalars, points, and public/secret keys composed thereof."
HOMEPAGE="https://github.com/RustCrypto/traits/tree/master/elliptic-curve"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"arithmetic"
	"bits"
	"default"
	"dev"
	"ecdh"
	"group"
	"hash2curve"
	"hazmat"
	"jwk"
	"pem"
	"pkcs8"
	"serde"
	"std"
	"voprf"
)
