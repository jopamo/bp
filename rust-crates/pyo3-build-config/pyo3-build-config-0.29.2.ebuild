# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="pyo3-build-config"
CRATE_VERSION="0.29.2"
CRATE_CHECKSUM="f41027e41b4bd03f6e60f9f417fe24a6341a6bb744edd62b6f709f2a52ea30e9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Build configuration for the PyO3 ecosystem"
HOMEPAGE="https://github.com/pyo3/pyo3"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"extension-module"
	"generate-import-lib"
	"resolve-config"
)
