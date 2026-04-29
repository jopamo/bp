# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="monostate"
CRATE_VERSION="0.1.18"
CRATE_CHECKSUM="3341a273f6c9d5bef1908f17b7267bbab0e95c9bf69a0d4dcf8e9e1b2c76ef67"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Type that deserializes only from one specific value"
HOMEPAGE="https://github.com/dtolnay/monostate"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
