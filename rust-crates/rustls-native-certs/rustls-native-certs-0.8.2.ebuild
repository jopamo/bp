# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rustls-native-certs"
CRATE_VERSION="0.8.2"
CRATE_CHECKSUM="9980d917ebb0c0536119ba501e90834767bffc3d60641457fd84a1f3fd337923"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="rustls-native-certs allows rustls to use the platform native certificate store"
HOMEPAGE="https://github.com/rustls/rustls-native-certs"
LICENSE="|| ( Apache-2.0 ISC MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
