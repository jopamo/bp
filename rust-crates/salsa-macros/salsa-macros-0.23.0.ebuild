# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="salsa-macros"
CRATE_VERSION="0.23.0"
CRATE_CHECKSUM="d0778d6e209051bc4e75acfe83bcd7848601ec3dbe9c3dbb982829020e9128af"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Procedural macros for the salsa crate"
HOMEPAGE="https://github.com/salsa-rs/salsa"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
