# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="syn"
CRATE_VERSION="3.0.3"
CRATE_CHECKSUM="53e9bae58849f64dfa4f5d5ae372c8341f7305f82a3868709269343628b659a3"
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
