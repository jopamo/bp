# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="petgraph"
CRATE_VERSION="0.7.1"
CRATE_CHECKSUM="3672b37090dbd86368a4145bc067582552b29c27377cad4e0a306c97f9bd7772"
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
