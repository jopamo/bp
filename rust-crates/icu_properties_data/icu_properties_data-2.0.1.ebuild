# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="icu_properties_data"
CRATE_VERSION="2.0.1"
CRATE_CHECKSUM="298459143998310acd25ffe6810ed544932242d3f07083eee1084d83a71bd632"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Data for the icu_properties crate"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
