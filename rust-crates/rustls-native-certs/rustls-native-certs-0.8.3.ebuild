# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="rustls-native-certs"
CRATE_VERSION="0.8.3"
CRATE_CHECKSUM="612460d5f7bea540c490b2b6395d8e34a953e52b491accd6c86c8164c5932a63"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="rustls-native-certs allows rustls to use the platform native certificate store"
HOMEPAGE="https://github.com/rustls/rustls-native-certs"
LICENSE="|| ( Apache-2.0 ISC MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
