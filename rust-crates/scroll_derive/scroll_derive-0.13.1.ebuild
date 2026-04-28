# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="scroll_derive"
CRATE_VERSION="0.13.1"
CRATE_CHECKSUM="ed76efe62313ab6610570951494bdaa81568026e0318eaa55f167de70eeea67d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A macros 1.1 derive implementation for Pread and Pwrite traits from the scroll crate"
HOMEPAGE="https://github.com/m4b/scroll"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
