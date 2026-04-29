# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pyo3"
CRATE_VERSION="0.28.3"
CRATE_CHECKSUM="91fd8e38a3b50ed1167fb981cd6fd60147e091784c427b8f7183a7ee32c31c12"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings to Python interpreter"
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
	"arc_lock"
	"auto-initialize"
	"bigdecimal"
	"chrono-local"
	"default"
	"experimental-async"
	"experimental-inspect"
	"extension-module"
	"full"
	"generate-import-lib"
	"macros"
	"multiple-pymethods"
	"nightly"
	"num-bigint"
	"parking_lot"
	"py-clone"
)
