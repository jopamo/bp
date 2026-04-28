# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="notify"
CRATE_VERSION="8.2.0"
CRATE_CHECKSUM="4d3d07927151ff8575b7087f245456e549fea62edf0ec4e565a5ee50c8402bc3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross-platform filesystem notification library"
HOMEPAGE="https://github.com/notify-rs/notify"
LICENSE="CC0-1.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"macos_fsevent"
	"macos_kqueue"
	"serde"
	"serialization-compat-6"
)
