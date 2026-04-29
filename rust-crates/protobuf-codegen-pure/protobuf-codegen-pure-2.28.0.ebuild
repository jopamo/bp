# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="protobuf-codegen-pure"
CRATE_VERSION="2.28.0"
CRATE_CHECKSUM="95a29399fc94bcd3eeaa951c715f7bea69409b2445356b00519740bcd6ddd865"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure-rust codegen for protobuf using protobuf-parser crate WIP"
HOMEPAGE="https://github.com/stepancheg/rust-protobuf/tree/master/protobuf-codegen-pure/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
