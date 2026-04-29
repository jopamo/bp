# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="numpy"
CRATE_VERSION="0.26.0"
CRATE_CHECKSUM="9b2dba356160b54f5371b550575b78130a54718b4c6e46b3f33a6da74a27e78b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="PyO3-based Rust bindings of the NumPy C-API"
HOMEPAGE="https://github.com/PyO3/rust-numpy"
LICENSE="BSD-2-Clause"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
