# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="smallvec"
CRATE_VERSION="1.15.2"
CRATE_CHECKSUM="8ed6a63f02c8539c91a8685a86f4099661ba3da017932f6ebbea6de3f0fa7c90"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="'Small vector' optimization: store up to a small number of items on the stack"
HOMEPAGE="https://github.com/servo/rust-smallvec"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"const_generics"
	"const_new"
	"debugger_visualizer"
	"drain_filter"
	"drain_keep_rest"
	"impl_bincode"
	"may_dangle"
	"specialization"
	"union"
	"write"
)
