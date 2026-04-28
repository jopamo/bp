# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra_ap_ide_db"
CRATE_VERSION="0.0.301"
CRATE_CHECKSUM="d2acb572d6dbeb1c96d0339890ba91298b8f5f0ab22648da4ee2b4ab77dbc3fe"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Core data structure representing IDE state for rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
