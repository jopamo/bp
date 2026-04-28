# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="terminal_size"
CRATE_VERSION="0.4.3"
CRATE_CHECKSUM="60b8cb979cb11c32ce1603f8137b22262a9d131aaa5c37b5678025f22b8becd0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Gets the size of your Linux or Windows terminal"
HOMEPAGE="https://github.com/eminence/terminal-size"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
