# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="pyo3-macros-backend"
CRATE_VERSION="0.30.1"
CRATE_CHECKSUM="38b89f066f2ae72a2aef52d1537ca2fcd104440ebfadee06e97aa90738a25b9b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Code generation for PyO3 package"
HOMEPAGE="https://pyo3.rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"experimental-async"
	"experimental-inspect"
)
