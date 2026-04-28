# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="socks"
CRATE_VERSION="0.3.4"
CRATE_CHECKSUM="f0c3dbbd9ae980613c6dd8e28a9407b50509d3803b57624d5dfe8315218cd58b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="SOCKS proxy clients"
HOMEPAGE="https://github.com/sfackler/rust-socks"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
