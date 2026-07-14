# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="syn"
CRATE_VERSION="2.0.118"
CRATE_CHECKSUM="1b9ae57f904213ebb649ce6895b8a66c66f0203b9319718f69a5612a065b1422"
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
