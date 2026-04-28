# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustls-native-certs"
CRATE_VERSION="0.7.0"
CRATE_CHECKSUM="8f1fb85efa936c42c6d5fc28d2629bb51e4b2f4b8a5211e297d599cc5a093792"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="rustls-native-certs allows rustls to use the platform native certificate store"
HOMEPAGE="https://github.com/rustls/rustls-native-certs"
LICENSE="|| ( Apache-2.0 ISC MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
