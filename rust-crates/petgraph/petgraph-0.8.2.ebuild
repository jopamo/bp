# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="petgraph"
CRATE_VERSION="0.8.2"
CRATE_CHECKSUM="54acf3a685220b533e437e264e4d932cfbdc4cc7ec0cd232ed73c08d03b8a7ca"
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
	"rayon"
	"serde-1"
	"stable_graph"
	"std"
	"unstable"
)
