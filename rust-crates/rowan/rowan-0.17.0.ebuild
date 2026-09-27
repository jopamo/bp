# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rowan"
CRATE_VERSION="0.17.0"
CRATE_CHECKSUM="14b574c58582fa59fa43a2feb6608b8744184659f08a2e0117e4b8224d95ed61"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library for generic lossless syntax trees"
HOMEPAGE="https://github.com/rust-analyzer/rowan"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"serde1"
)
