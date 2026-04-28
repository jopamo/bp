# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra_ap_base_db"
CRATE_VERSION="0.0.301"
CRATE_CHECKSUM="e876bb2c3e52a8d4e6684526a2d4e81f9d028b939ee4dc5dc775fe10deb44d59"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Basic database traits for rust-analyzer. The concrete DB is defined by `ide` (aka `ra_ap_ide`)."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
