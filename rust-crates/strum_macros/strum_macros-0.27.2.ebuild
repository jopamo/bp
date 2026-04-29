# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="strum_macros"
CRATE_VERSION="0.27.2"
CRATE_CHECKSUM="7695ce3845ea4b33927c055a39dc438a45b059f7c1b3d91d38d10355fb8cbca7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Helpful macros for working with enums and strings"
HOMEPAGE="https://github.com/Peternator7/strum"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
