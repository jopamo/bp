# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="pyo3"
CRATE_VERSION="0.26.0"
CRATE_CHECKSUM="7ba0117f4212101ee6544044dae45abe1083d30ce7b29c4b5cbdfa2354e07383"
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
	"parking_lot"
	"py-clone"
)
