# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="pyo3-macros"
CRATE_VERSION="0.30.1"
CRATE_CHECKSUM="c46d2e5862c7bb8207e3b639f713dda3c499933444784154c11d013c5a691b60"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Proc macros for PyO3 package"
HOMEPAGE="https://pyo3.rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"experimental-async"
	"experimental-inspect"
	"multiple-pymethods"
)
