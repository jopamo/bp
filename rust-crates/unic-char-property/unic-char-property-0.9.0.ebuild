# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="unic-char-property"
CRATE_VERSION="0.9.0"
CRATE_CHECKSUM="a8c57a407d9b6fa02b4795eb81c5b6652060a15a7903ea981f3d723e6c0be221"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="UNIC — Unicode Character Tools — Character Property taxonomy, contracts and build macros"
HOMEPAGE="https://github.com/open-i18n/rust-unic/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
