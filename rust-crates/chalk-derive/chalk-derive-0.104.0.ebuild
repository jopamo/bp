# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="chalk-derive"
CRATE_VERSION="0.104.0"
CRATE_CHECKSUM="9ea9b1e80910f66ae87c772247591432032ef3f6a67367ff17f8343db05beafa"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A helper crate for use by chalk crates for `derive` macros."
HOMEPAGE="https://github.com/rust-lang/chalk"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
