# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="tokio-retry"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="7f57eb36ecbe0fc510036adff84824dd3c24bb781e21bfa67b69d556aa85214f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Extensible, asynchronous retry behaviours for futures/tokio"
HOMEPAGE="https://github.com/srijs/rust-tokio-retry"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
