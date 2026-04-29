# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="icu_properties"
CRATE_VERSION="2.1.2"
CRATE_CHECKSUM="020bfc02fe870ec3a66d93e677ccca0562506e5872c650f893269e08615d74ec"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Definitions for Unicode properties"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"compiled_data"
	"datagen"
	"default"
	"serde"
	"unicode_bidi"
)
