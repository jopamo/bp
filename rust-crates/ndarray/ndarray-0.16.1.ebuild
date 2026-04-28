# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ndarray"
CRATE_VERSION="0.16.1"
CRATE_CHECKSUM="882ed72dce9365842bf196bdeedf5055305f11fc8c03dee7bb0194a6cad34841"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An n-dimensional array for general elements and for numerics. Lightweight array views and slicing; views support chunking and splitting."
HOMEPAGE="https://github.com/rust-ndarray/ndarray"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"blas"
	"default"
	"docs"
	"matrixmultiply-threading"
	"portable-atomic-critical-section"
	"rayon"
	"serde"
	"serde-1"
	"std"
	"test"
)
