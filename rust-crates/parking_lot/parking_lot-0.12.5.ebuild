# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="parking_lot"
CRATE_VERSION="0.12.5"
CRATE_CHECKSUM="93857453250e3077bd71ff98b6a65ea6621a19bb0f559a85248955ac12c45a1a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="More compact and efficient implementations of the standard synchronization primitives."
HOMEPAGE="https://github.com/Amanieu/parking_lot"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

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
