# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="monostate-impl"
CRATE_VERSION="0.1.16"
CRATE_CHECKSUM="88d4b3dcd6ce9277a52fb05f00bf3e45d475af8cce7376de2f8d6bd065fa4adb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation detail of the monostate crate"
HOMEPAGE="https://github.com/dtolnay/monostate"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
