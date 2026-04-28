# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pyo3-macros-backend"
CRATE_VERSION="0.26.0"
CRATE_CHECKSUM="100246c0ecf400b475341b8455a9213344569af29a3c841d29270e53102e0fcf"
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
