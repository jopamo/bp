# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="icu_calendar_data"
CRATE_VERSION="2.0.0"
CRATE_CHECKSUM="7219c8639ab936713a87b571eed2bc2615aa9137e8af6eb221446ee5644acc18"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Data for the icu_calendar crate"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
