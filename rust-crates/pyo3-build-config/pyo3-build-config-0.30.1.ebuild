# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="pyo3-build-config"
CRATE_VERSION="0.30.1"
CRATE_CHECKSUM="70130e2b6dd1ee589a8788026a429561ca5c40fa7a2fa7914c2282eddae24700"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Build configuration for the PyO3 ecosystem"
HOMEPAGE="https://pyo3.rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"extension-module"
	"generate-import-lib"
	"resolve-config"
)
