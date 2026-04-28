# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dyn-clone"
CRATE_VERSION="1.0.17"
CRATE_CHECKSUM="0d6ef0072f8a535281e4876be788938b528e9a1d43900b82c2569af7da799125"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Clone trait that is object-safe"
HOMEPAGE="https://github.com/dtolnay/dyn-clone"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
