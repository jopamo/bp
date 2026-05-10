# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="pest"
CRATE_VERSION="2.8.6"
CRATE_CHECKSUM="e0848c601009d37dfa3430c4666e147e49cdcf1b92ecd3e63657d8a5f19da662"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The Elegant Parser"
HOMEPAGE="https://pest.rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"const_prec_climber"
	"default"
	"miette-error"
	"pretty-print"
	"std"
)
