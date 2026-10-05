# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="dprint-swc-ext"
CRATE_VERSION="0.26.0"
CRATE_CHECKSUM="33175ddb7a6d418589cab2966bd14a710b3b1139459d3d5ca9edf783c4833f4c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Functionality to make swc easier to work with."
HOMEPAGE="https://github.com/dprint/dprint-swc-ext"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"sourcemap"
	"view"
)
