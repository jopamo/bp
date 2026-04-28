# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="itoa"
CRATE_VERSION="1.0.17"
CRATE_CHECKSUM="92ecc6618181def0457392ccd0ee51198e065e016d1d527a7ac1b6dc7c1f09d2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast integer primitive to string conversion"
HOMEPAGE="https://github.com/dtolnay/itoa"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
