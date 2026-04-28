# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="parking_lot_core"
CRATE_VERSION="0.9.11"
CRATE_CHECKSUM="bc838d2a56b5b1a6c25f55575dfc605fabb63bb2365f6c2353ef9159aa69e4a5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An advanced API for creating custom synchronization primitives."
HOMEPAGE="https://github.com/Amanieu/parking_lot"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"deadlock_detection"
	"nightly"
)
