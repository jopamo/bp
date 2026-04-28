# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="unic-ucd-version"
CRATE_VERSION="0.9.0"
CRATE_CHECKSUM="96bd2f2237fe450fcd0a1d2f5f4e91711124f7857ba2e964247776ebeeb7b0c4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="UNIC — Unicode Character Database — Version"
HOMEPAGE="https://github.com/open-i18n/rust-unic/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
