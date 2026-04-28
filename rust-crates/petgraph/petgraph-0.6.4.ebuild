# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="petgraph"
CRATE_VERSION="0.6.4"
CRATE_CHECKSUM="e1d3afd2628e69da2be385eb6f2fd57c8ac7977ceeff6dc166ff1657b0e386a9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Graph data structure library. Provides graph types and graph algorithms."
HOMEPAGE="https://github.com/petgraph/petgraph"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"all"
	"default"
	"generate"
	"graphmap"
	"matrix_graph"
	"serde-1"
	"stable_graph"
	"unstable"
)
