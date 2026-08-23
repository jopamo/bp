# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ra_ap_cfg"
CRATE_VERSION="0.0.328"
CRATE_CHECKSUM="1e1fc8d53014b0ec4c06c9dbf0a810ccd67b3a96de4ef06bd1a248c2295b6a37"
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
