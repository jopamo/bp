# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="schannel"
CRATE_VERSION="0.1.29"
CRATE_CHECKSUM="91c1b7e4904c873ef0710c1f407dde2e6287de2bebc1bbbf7d430bb7cbffd939"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Schannel bindings for rust, allowing SSL/TLS (e.g. https) without openssl"
HOMEPAGE="https://github.com/steffengy/schannel-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
