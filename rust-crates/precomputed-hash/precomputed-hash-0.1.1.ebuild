# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="precomputed-hash"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="925383efa346730478fb4838dbe9137d2a47675ad789c546d150a6e1dd4ab31c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library intending to be a base dependency to expose a precomputed hash"
HOMEPAGE="https://github.com/emilio/precomputed-hash"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
