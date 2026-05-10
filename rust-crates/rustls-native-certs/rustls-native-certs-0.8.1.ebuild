# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rustls-native-certs"
CRATE_VERSION="0.8.1"
CRATE_CHECKSUM="7fcff2dd52b58a8d98a70243663a0d234c4e2b79235637849d15913394a247d3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="rustls-native-certs allows rustls to use the platform native certificate store"
HOMEPAGE="https://github.com/rustls/rustls-native-certs"
LICENSE="|| ( Apache-2.0 ISC MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
