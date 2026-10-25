# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="pyo3-ffi"
CRATE_VERSION="0.30.1"
CRATE_CHECKSUM="5e7ff73c555c286d212d4ce7e5fbda845a973c4f61bd5f160f5f2c3c2a04d1c4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Python-API bindings for the PyO3 ecosystem"
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
	"default"
	"extension-module"
	"generate-import-lib"
)
