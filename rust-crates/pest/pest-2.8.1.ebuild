# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="pest"
CRATE_VERSION="2.8.1"
CRATE_CHECKSUM="1db05f56d34358a8b1066f67cbb203ee3e7ed2ba674a6263a1d5ec6db2204323"
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
