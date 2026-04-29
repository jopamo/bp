# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="more-asserts"
CRATE_VERSION="0.3.1"
CRATE_CHECKSUM="1fafa6961cabd9c63bcd77a45d7e3b7f3b552b70417831fb0f56db717e72407e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Small library providing additional assert_* and debug_assert_* macros."
HOMEPAGE="https://github.com/thomcc/rust-more-asserts"
LICENSE="|| ( Unlicense MIT Apache-2.0 CC0-1.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
