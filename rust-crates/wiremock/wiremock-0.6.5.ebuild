# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="wiremock"
CRATE_VERSION="0.6.5"
CRATE_CHECKSUM="08db1edfb05d9b3c1542e521aea074442088292f00b5f28e435c714a98f85031"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="HTTP mocking to test Rust applications."
HOMEPAGE="https://github.com/LukeMathWalker/wiremock-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
