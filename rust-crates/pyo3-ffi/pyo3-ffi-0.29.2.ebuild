# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="pyo3-ffi"
CRATE_VERSION="0.29.2"
CRATE_CHECKSUM="e591a95526fead067432c3b3a33fc74770b87b1e04e73671090d9c2055a2b327"
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
	"abi3-py315"
	"abi3-py38"
	"abi3-py39"
	"abi3t"
	"abi3t-py315"
	"default"
	"extension-module"
	"generate-import-lib"
)
