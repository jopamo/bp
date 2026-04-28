# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="numpy"
CRATE_VERSION="0.25.0"
CRATE_CHECKSUM="29f1dee9aa8d3f6f8e8b9af3803006101bb3653866ef056d530d53ae68587191"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="PyO3-based Rust bindings of the NumPy C-API"
HOMEPAGE="https://github.com/PyO3/rust-numpy"
LICENSE="BSD-2-Clause"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
