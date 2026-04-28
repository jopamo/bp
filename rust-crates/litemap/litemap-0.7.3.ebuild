# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="litemap"
CRATE_VERSION="0.7.3"
CRATE_CHECKSUM="643cb0b8d4fcc284004d5fd0d67ccf61dfffadb7f75e1e71bc420f4688a3a704"
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
	"bench"
	"databake"
	"default"
	"serde"
	"testing"
	"yoke"
)
