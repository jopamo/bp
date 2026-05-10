# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="petgraph"
CRATE_VERSION="0.8.3"
CRATE_CHECKSUM="8701b58ea97060d5e5b155d383a69952a60943f0e6dfe30b04c287beb0b27455"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Graph data structure library. Provides graph types and graph algorithms."
HOMEPAGE="https://github.com/petgraph/petgraph"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"all"
	"default"
	"dot_parser"
	"generate"
	"graphmap"
	"matrix_graph"
	"quickcheck"
	"rayon"
	"serde-1"
	"stable_graph"
	"std"
	"unstable"
)
