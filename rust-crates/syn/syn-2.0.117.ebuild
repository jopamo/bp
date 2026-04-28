# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="syn"
CRATE_VERSION="2.0.117"
CRATE_CHECKSUM="e665b8803e7b1d2a727f4023456bbbbe74da67099c585258af0ad9c5013b9b99"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parser for Rust source code"
HOMEPAGE="https://github.com/dtolnay/syn"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"clone-impls"
	"default"
	"derive"
	"extra-traits"
	"fold"
	"full"
	"parsing"
	"printing"
	"proc-macro"
	"test"
	"visit"
	"visit-mut"
)
