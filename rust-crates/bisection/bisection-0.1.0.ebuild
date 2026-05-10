# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="bisection"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="021e079a1bab0ecce6cf4b4b74c0c37afa4a697136eb3b127875c84a8f04a8c3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust implementation of the Python bisect module"
HOMEPAGE="https://github.com/SteadBytes/bisection"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
