# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="litemap"
CRATE_VERSION="0.8.0"
CRATE_CHECKSUM="241eaef5fd12c88705a01fc1066c48c4b36e0dd4377dcdc7ec3942cea7a69956"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A key-value Map implementation based on a flat, sorted Vec."
HOMEPAGE="https://github.com/unicode-org/icu4x"
LICENSE="Unicode-3.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"databake"
	"default"
	"serde"
	"testing"
	"yoke"
)
