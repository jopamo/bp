# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="elliptic-curve"
CRATE_VERSION="0.14.0-rc.28"
CRATE_CHECKSUM="bde7860544606d222fd6bd6d9f9a0773321bf78072a637e1d560a058c0031978"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="General purpose Elliptic Curve Cryptography (ECC) support, including types and traits for representing various elliptic curve forms, scalars, points, and public/secret keys composed thereof."
HOMEPAGE="https://github.com/RustCrypto/traits"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"arithmetic"
	"basepoint-table"
	"bits"
	"critical-section"
	"default"
	"dev"
	"ecdh"
	"getrandom"
	"group"
	"pem"
	"pkcs8"
	"serde"
	"std"
)
