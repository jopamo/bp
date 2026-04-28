# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pin-project-lite"
CRATE_VERSION="0.2.14"
CRATE_CHECKSUM="bda66fc9667c18cb2758a2ac84d1167245054bcf85d5d1aaa6923f45801bdd02"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A lightweight version of pin-project written with declarative macros."
HOMEPAGE="https://github.com/taiki-e/pin-project-lite"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
