# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pyo3-macros-backend"
CRATE_VERSION="0.28.2"
CRATE_CHECKSUM="22faaa1ce6c430a1f71658760497291065e6450d7b5dc2bcf254d49f66ee700a"
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
