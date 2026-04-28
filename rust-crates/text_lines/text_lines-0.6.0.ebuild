# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="text_lines"
CRATE_VERSION="0.6.0"
CRATE_CHECKSUM="7fd5828de7deaa782e1dd713006ae96b3bee32d3279b79eb67ecf8072c059bcf"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Information about lines of text in a string."
HOMEPAGE="https://crates.io/crates/text_lines"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"serialization"
)
