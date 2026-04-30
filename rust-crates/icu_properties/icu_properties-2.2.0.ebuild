# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="icu_properties"
CRATE_VERSION="2.2.0"
CRATE_CHECKSUM="bee3b67d0ea5c2cca5003417989af8996f8604e34fb9ddf96208a033901e70de"
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
	"harfbuzz_traits"
	"serde"
	"unicode_bidi"
)
