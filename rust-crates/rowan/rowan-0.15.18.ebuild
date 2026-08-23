# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rowan"
CRATE_VERSION="0.15.18"
CRATE_CHECKSUM="62f509095fc8cc0c8c8564016771d458079c11a8d857e65861f045145c0d3208"
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
