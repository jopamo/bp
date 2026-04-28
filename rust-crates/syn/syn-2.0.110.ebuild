# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="syn"
CRATE_VERSION="2.0.110"
CRATE_CHECKSUM="a99801b5bd34ede4cf3fc688c5919368fea4e4814a4664359503e6015b280aea"
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
