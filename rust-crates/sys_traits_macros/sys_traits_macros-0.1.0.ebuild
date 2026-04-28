# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="sys_traits_macros"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="181f22127402abcf8ee5c83ccd5b408933fec36a6095cf82cda545634692657e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Procedural macros for sys_traits."
HOMEPAGE="https://github.com/dsherret/sys_traits"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
