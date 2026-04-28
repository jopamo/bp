# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="capacity_builder_macros"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="3b4a6cae9efc04cc6cbb8faf338d2c497c165c83e74509cf4dbedea948bbf6e5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macros for capacity_builder"
HOMEPAGE="https://github.com/dsherret/capacity_builder"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
