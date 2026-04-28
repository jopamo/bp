# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dyn-clone"
CRATE_VERSION="1.0.20"
CRATE_CHECKSUM="d0881ea181b1df73ff77ffaaf9c7544ecc11e82fba9b5f27b262a3c73a332555"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Clone trait that is dyn-compatible"
HOMEPAGE="https://github.com/dtolnay/dyn-clone"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
