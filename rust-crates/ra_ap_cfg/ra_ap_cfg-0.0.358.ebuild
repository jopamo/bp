# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ra_ap_cfg"
CRATE_VERSION="0.0.358"
CRATE_CHECKSUM="1dc63ce4a2acd1591cac5d5ad1d4f0549bd9069f4aad59acbf600a4d4881a8c9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Conditional compiling options, \`cfg\` attribute parser and evaluator for rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"in-rust-tree"
	"syntax"
	"tt"
)
