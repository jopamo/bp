# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="smallvec"
CRATE_VERSION="1.16.1"
CRATE_CHECKSUM="ba467056f1b547ed52077911161fc86985becbc60e8e1857c8a144dab0def891"
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
	"drain_filter"
	"drain_keep_rest"
	"impl_bincode"
	"may_dangle"
	"specialization"
	"union"
	"write"
)
