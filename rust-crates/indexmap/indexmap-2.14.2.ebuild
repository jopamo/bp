# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="indexmap"
CRATE_VERSION="2.14.2"
CRATE_CHECKSUM="cc4e190f5d26ca7051642629da2c52fc03bde85a03197c99408dcd291734c855"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A hash table with consistent order and fast iteration."
HOMEPAGE="https://github.com/indexmap-rs/indexmap"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"serde"
	"std"
	"test_debug"
)
