# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="try-lock"
CRATE_VERSION="0.2.5"
CRATE_CHECKSUM="e421abadd41a4225275504ea4d6566923418b7f05506fbc9c0fe86ba7396114b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A lightweight atomic lock."
HOMEPAGE="https://github.com/seanmonstar/try-lock"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
