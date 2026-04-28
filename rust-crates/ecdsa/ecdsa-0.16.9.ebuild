# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ecdsa"
CRATE_VERSION="0.16.9"
CRATE_CHECKSUM="ee27f32b5c5292967d2d4a9d7f1e0b0aed2c15daded5a60300e4abb9d8020bca"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of the Elliptic Curve Digital Signature Algorithm (ECDSA) as specified in FIPS 186-4 (Digital Signature Standard), providing RFC6979 deterministic signatures as well as support for added entropy"
HOMEPAGE="https://github.com/RustCrypto/signatures/tree/master/ecdsa"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"arithmetic"
	"default"
	"dev"
	"digest"
	"hazmat"
	"pem"
	"pkcs8"
	"serde"
	"signing"
	"std"
	"verifying"
)
