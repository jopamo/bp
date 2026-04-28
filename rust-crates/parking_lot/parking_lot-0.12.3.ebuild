# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="parking_lot"
CRATE_VERSION="0.12.3"
CRATE_CHECKSUM="f1bf18183cf54e8d6059647fc3063646a1801cf30896933ec2311622cc4b9a27"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="More compact and efficient implementations of the standard synchronization primitives."
HOMEPAGE="https://github.com/Amanieu/parking_lot"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"arc_lock"
	"deadlock_detection"
	"default"
	"hardware-lock-elision"
	"nightly"
	"owning_ref"
	"send_guard"
	"serde"
)
