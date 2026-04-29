# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pyo3-macros"
CRATE_VERSION="0.28.3"
CRATE_CHECKSUM="df6e520eff47c45997d2fc7dd8214b25dd1310918bbb2642156ef66a67f29813"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Proc macros for PyO3 package"
HOMEPAGE="https://github.com/pyo3/pyo3"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"experimental-async"
	"experimental-inspect"
	"multiple-pymethods"
)
