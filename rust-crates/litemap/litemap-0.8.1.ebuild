# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="litemap"
CRATE_VERSION="0.8.1"
CRATE_CHECKSUM="6373607a59f0be73a39b6fe456b8192fcc3585f602af20751600e974dd455e77"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A key-value Map implementation based on a flat, sorted Vec."
HOMEPAGE="https://github.com/unicode-org/icu4x"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"databake"
	"default"
	"serde"
	"testing"
	"yoke"
)
