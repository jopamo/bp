# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="protobuf-support"
CRATE_VERSION="3.7.2"
CRATE_CHECKSUM="3e36c2f31e0a47f9280fb347ef5e461ffcd2c52dd520d8e216b52f93b0b0d7d6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Code supporting protobuf implementation. None of code in this crate is public API."
HOMEPAGE="https://github.com/stepancheg/rust-protobuf/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
