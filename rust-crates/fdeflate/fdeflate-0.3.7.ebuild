# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fdeflate"
CRATE_VERSION="0.3.7"
CRATE_CHECKSUM="1e6853b52649d4ac5c0bd02320cddc5ba956bdb407c4b75a2c6b75bf51500f8c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast specialized deflate implementation"
HOMEPAGE="https://github.com/image-rs/fdeflate"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
