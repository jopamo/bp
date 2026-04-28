# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="itoa"
CRATE_VERSION="1.0.18"
CRATE_CHECKSUM="8f42a60cbdf9a97f5d2305f08a87dc4e09308d1276d28c869c684d7777685682"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast integer primitive to string conversion"
HOMEPAGE="https://github.com/dtolnay/itoa"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
