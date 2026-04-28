# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="icu_properties"
CRATE_VERSION="2.0.1"
CRATE_CHECKSUM="016c619c1eeb94efb86809b015c58f479963de65bdb6253345c1a1276f22e32b"
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
