# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="strum_macros"
CRATE_VERSION="0.26.4"
CRATE_CHECKSUM="4c6bee85a5a24955dc440386795aa378cd9cf82acd5f764469152d2270e581be"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Helpful macros for working with enums and strings"
HOMEPAGE="https://github.com/Peternator7/strum"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
