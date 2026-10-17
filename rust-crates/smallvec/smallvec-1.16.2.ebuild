# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="smallvec"
CRATE_VERSION="1.16.2"
CRATE_CHECKSUM="f9395f0f0eee849a9b707b2f06bb92a6a422090e2123bb2ef8e87a0e61892a8e"
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
