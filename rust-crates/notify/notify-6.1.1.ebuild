# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="notify"
CRATE_VERSION="6.1.1"
CRATE_CHECKSUM="6205bd8bb1e454ad2e27422015fb5e4f2bcc7e08fa8f27058670d208324a4d2d"
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
	"manual_tests"
	"timing_tests"
)
