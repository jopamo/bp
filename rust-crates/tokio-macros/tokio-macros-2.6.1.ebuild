# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="tokio-macros"
CRATE_VERSION="2.6.1"
CRATE_CHECKSUM="5c55a2eff8b69ce66c84f85e1da1c233edc36ceb85a2058d11b0d6a3c7e7569c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Tokio's proc macros."
HOMEPAGE="https://tokio.rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
