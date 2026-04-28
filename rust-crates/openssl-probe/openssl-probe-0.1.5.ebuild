# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="openssl-probe"
CRATE_VERSION="0.1.5"
CRATE_CHECKSUM="ff011a302c396a5197692431fc1948019154afc178baf7d8e37367442a4601cf"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Tool for helping to find SSL certificate locations on the system for OpenSSL"
HOMEPAGE="https://github.com/alexcrichton/openssl-probe"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
