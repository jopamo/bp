# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="prost-derive"
CRATE_VERSION="0.14.3"
CRATE_CHECKSUM="27c6023962132f4b30eb4c172c91ce92d933da334c59c23cddee82358ddafb0b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generate encoding and decoding implementations for Prost annotated types."
HOMEPAGE="https://github.com/tokio-rs/prost"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
