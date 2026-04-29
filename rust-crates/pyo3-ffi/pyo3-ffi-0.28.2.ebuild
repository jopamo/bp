# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="pyo3-ffi"
CRATE_VERSION="0.28.2"
CRATE_CHECKSUM="491aa5fc66d8059dd44a75f4580a2962c1862a1c2945359db36f6c2818b748dc"
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
