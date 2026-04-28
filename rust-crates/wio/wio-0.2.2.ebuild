# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wio"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="5d129932f4644ac2396cb456385cbf9e63b5b30c6e8dc4820bdca4eb082037a5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Windows IO wrapper"
HOMEPAGE="https://github.com/retep998/wio-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
