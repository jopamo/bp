# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="parking_lot_core"
CRATE_VERSION="0.9.9"
CRATE_CHECKSUM="4c42a9226546d68acdd9c0a280d17ce19bfe27a46bf68784e4066115788d008e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An advanced API for creating custom synchronization primitives."
HOMEPAGE="https://github.com/Amanieu/parking_lot"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"deadlock_detection"
	"nightly"
)
