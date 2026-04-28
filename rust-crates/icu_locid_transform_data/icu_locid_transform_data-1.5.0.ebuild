# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="icu_locid_transform_data"
CRATE_VERSION="1.5.0"
CRATE_CHECKSUM="fdc8ff3388f852bede6b579ad4e978ab004f139284d7b28715f773507b946f6e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Data for the icu_locid_transform crate"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
