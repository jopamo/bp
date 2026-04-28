# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="xkeysym"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="b9cc00251562a284751c9973bace760d86c0276c471b4be569fe6b068ee97a56"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library for working with X11 keysyms"
HOMEPAGE="https://github.com/notgull/xkeysym"
LICENSE="|| ( MIT Apache-2.0 Zlib )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
