# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="schannel"
CRATE_VERSION="0.1.23"
CRATE_CHECKSUM="fbc91545643bcf3a0bbb6569265615222618bdf33ce4ffbbd13c4bbd4c093534"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Schannel bindings for rust, allowing SSL/TLS (e.g. https) without openssl"
HOMEPAGE="https://github.com/steffengy/schannel-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
