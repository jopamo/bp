# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="icu_properties_data"
CRATE_VERSION="2.1.2"
CRATE_CHECKSUM="616c294cf8d725c6afcd8f55abc17c56464ef6211f9ed59cccffe534129c77af"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Data for the icu_properties crate"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
