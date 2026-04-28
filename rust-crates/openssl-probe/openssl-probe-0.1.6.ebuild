# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="openssl-probe"
CRATE_VERSION="0.1.6"
CRATE_CHECKSUM="d05e27ee213611ffe7d6348b942e8f942b37114c00cc03cec254295a4a17852e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Tool for helping to find SSL certificate locations on the system for OpenSSL"
HOMEPAGE="https://github.com/alexcrichton/openssl-probe"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
