# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="icu_calendar"
CRATE_VERSION="2.0.4"
CRATE_CHECKSUM="20d8f41e97997bf55d0533f45d67453355cfa9a8990b0b058bedc28df1a5cec2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Date APIs for Gregorian and non-Gregorian calendars"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"compiled_data"
	"datagen"
	"default"
	"ixdtf"
	"logging"
	"serde"
)
