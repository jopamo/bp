# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ordermap"
CRATE_VERSION="1.1.0"
CRATE_CHECKSUM="cfa78c92071bbd3628c22b1a964f7e0eb201dc1456555db072beb1662ecd6715"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A hash table with consistent order and fast iteration."
HOMEPAGE="https://github.com/indexmap-rs/ordermap"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"arbitrary"
	"borsh"
	"default"
	"quickcheck"
	"rayon"
	"serde"
	"std"
	"sval"
)
