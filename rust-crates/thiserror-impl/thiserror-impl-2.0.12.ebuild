# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="thiserror-impl"
CRATE_VERSION="2.0.12"
CRATE_CHECKSUM="7f7cf42b4507d8ea322120659672cf1b9dbb93f8f2d4ecfd6e51350ff5b17a1d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation detail of the `thiserror` crate"
HOMEPAGE="https://github.com/dtolnay/thiserror"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
