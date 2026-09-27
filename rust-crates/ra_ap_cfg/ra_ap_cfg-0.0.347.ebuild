# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ra_ap_cfg"
CRATE_VERSION="0.0.347"
CRATE_CHECKSUM="c50ba7c60bc08ef48d2a930c5f897349fb0a72cf53e86c0374476f2583d1f098"
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
