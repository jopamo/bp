# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="utf8-width"
CRATE_VERSION="0.1.7"
CRATE_CHECKSUM="86bd8d4e895da8537e5315b8254664e6b769c4ff3db18321b297a1e7004392e3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="To determine the width of a UTF-8 character by providing its first byte."
HOMEPAGE="https://magiclen.org/utf8-width"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
