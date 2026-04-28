# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pyo3-ffi"
CRATE_VERSION="0.25.1"
CRATE_CHECKSUM="7114fe5457c61b276ab77c5055f206295b812608083644a5c5b2640c3102565c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Python-API bindings for the PyO3 ecosystem"
HOMEPAGE="https://github.com/pyo3/pyo3"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"abi3"
	"abi3-py310"
	"abi3-py311"
	"abi3-py312"
	"abi3-py313"
	"abi3-py314"
	"abi3-py37"
	"abi3-py38"
	"abi3-py39"
	"default"
	"extension-module"
	"generate-import-lib"
)
