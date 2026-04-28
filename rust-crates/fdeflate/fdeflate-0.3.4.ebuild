# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fdeflate"
CRATE_VERSION="0.3.4"
CRATE_CHECKSUM="4f9bfee30e4dedf0ab8b422f03af778d9612b63f502710fc500a334ebe2de645"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast specialized deflate implementation"
HOMEPAGE="https://github.com/image-rs/fdeflate"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
