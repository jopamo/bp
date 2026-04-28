# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="yoke-derive"
CRATE_VERSION="0.8.0"
CRATE_CHECKSUM="38da3c9736e16c5d3c8c597a9aaa5d1fa565d0532ae05e27c24aa62fb32c0ab6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Custom derive for the yoke crate"
HOMEPAGE="https://github.com/unicode-org/icu4x"
LICENSE="Unicode-3.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
