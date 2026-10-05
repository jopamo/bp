# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="icu_calendar"
CRATE_VERSION="2.2.1"
CRATE_CHECKSUM="a2b2acc6263f494f1df50685b53ff8e57869e47d5c6fe39c23d518ae9a4f3e45"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Date APIs for Gregorian and non-Gregorian calendars"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"compiled_data"
	"datagen"
	"default"
	"ixdtf"
	"logging"
	"serde"
	"unstable"
	"unstable_chrono_0_4"
	"unstable_jiff_0_2"
	"unstable_time_0_3"
)
