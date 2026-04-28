# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="parking_lot_core"
CRATE_VERSION="0.9.12"
CRATE_CHECKSUM="2621685985a2ebf1c516881c026032ac7deafcda1a2c9b7850dc81e3dfcb64c1"
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
