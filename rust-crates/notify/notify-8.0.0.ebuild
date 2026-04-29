# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="notify"
CRATE_VERSION="8.0.0"
CRATE_CHECKSUM="2fee8403b3d66ac7b26aee6e40a897d85dc5ce26f44da36b8b73e987cc52e943"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross-platform filesystem notification library"
HOMEPAGE="https://github.com/notify-rs/notify"
LICENSE="CC0-1.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"macos_fsevent"
	"macos_kqueue"
	"serde"
	"serialization-compat-6"
)
