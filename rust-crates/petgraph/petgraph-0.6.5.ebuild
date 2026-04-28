# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="petgraph"
CRATE_VERSION="0.6.5"
CRATE_CHECKSUM="b4c5cc86750666a3ed20bdaf5ca2a0344f9c67674cae0515bec2da16fbaa47db"
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
	"generate"
	"graphmap"
	"matrix_graph"
	"rayon"
	"serde-1"
	"stable_graph"
	"unstable"
)
