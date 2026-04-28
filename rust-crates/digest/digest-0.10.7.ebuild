# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="digest"
CRATE_VERSION="0.10.7"
CRATE_CHECKSUM="9ed9a281f7bc9b7576e61468ba615a66a5c8cfdff42420a70aa82701a3b1e292"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Traits for cryptographic hash functions and message authentication codes"
HOMEPAGE="https://github.com/RustCrypto/traits"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"core-api"
	"default"
	"dev"
	"mac"
	"oid"
	"rand_core"
	"std"
)
