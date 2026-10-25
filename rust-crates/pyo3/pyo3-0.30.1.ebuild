# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="pyo3"
CRATE_VERSION="0.30.1"
CRATE_CHECKSUM="229ca13b8a15bb0d1487b81ab975bfcd97513416499a8312011b6036e42e0de4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings to Python interpreter"
HOMEPAGE="https://pyo3.rs/"
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
	"abi3-py315"
	"abi3-py39"
	"abi3t"
	"abi3t-py315"
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
