# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="prost-derive"
CRATE_VERSION="0.12.6"
CRATE_CHECKSUM="81bddcdb20abf9501610992b6759a4c888aef7d1a7247ef75e2404275ac24af1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generate encoding and decoding implementations for Prost annotated types."
HOMEPAGE="https://github.com/tokio-rs/prost"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
