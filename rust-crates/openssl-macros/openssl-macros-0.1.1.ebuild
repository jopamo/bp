# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="openssl-macros"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="a948666b637a0f465e8564c73e89d4dde00d72d4d473cc972f390fc3dcee7d9c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Internal macros used by the openssl crate."
HOMEPAGE="https://crates.io/crates/openssl-macros"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
