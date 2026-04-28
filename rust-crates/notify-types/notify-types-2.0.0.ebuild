# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="notify-types"
CRATE_VERSION="2.0.0"
CRATE_CHECKSUM="5e0826a989adedc2a244799e823aece04662b66609d96af8dff7ac6df9a8925d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Types used by the notify crate"
HOMEPAGE="https://github.com/notify-rs/notify"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"serialization-compat-6"
)
