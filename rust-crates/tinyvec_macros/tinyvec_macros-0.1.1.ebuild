# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tinyvec_macros"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="1f3ccbac311fea05f86f61904b462b55fb3df8837a366dfc601a0161d0532f20"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Some macros for tiny containers"
HOMEPAGE="https://github.com/Soveu/tinyvec_macros"
LICENSE="|| ( MIT Apache-2.0 Zlib )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
