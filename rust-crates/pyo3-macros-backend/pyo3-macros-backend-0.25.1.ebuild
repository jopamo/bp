# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pyo3-macros-backend"
CRATE_VERSION="0.25.1"
CRATE_CHECKSUM="4109984c22491085343c05b0dbc54ddc405c3cf7b4374fc533f5c3313a572ccc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Code generation for PyO3 package"
HOMEPAGE="https://github.com/pyo3/pyo3"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"experimental-async"
	"experimental-inspect"
)
