# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="icu_normalizer_data"
CRATE_VERSION="2.0.0"
CRATE_CHECKSUM="00210d6893afc98edb752b664b8890f0ef174c8adbb8d0be9710fa66fbbf72d3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Data for the icu_normalizer crate"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
