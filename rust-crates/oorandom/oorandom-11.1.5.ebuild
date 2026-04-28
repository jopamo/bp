# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="oorandom"
CRATE_VERSION="11.1.5"
CRATE_CHECKSUM="d6790f58c7ff633d8771f42965289203411a5e5c68388703c06e14f24770b41e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A tiny, robust PRNG implementation."
HOMEPAGE="https://hg.sr.ht/~icefox/oorandom"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
