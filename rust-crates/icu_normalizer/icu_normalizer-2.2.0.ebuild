# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="icu_normalizer"
CRATE_VERSION="2.2.0"
CRATE_CHECKSUM="c56e5ee99d6e3d33bd91c5d85458b6005a22140021cc324cea84dd0e72cff3b4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="API for normalizing text into Unicode Normalization Forms"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"compiled_data"
	"datagen"
	"default"
	"harfbuzz_traits"
	"icu_properties"
	"serde"
	"utf16_iter"
	"utf8_iter"
	"write16"
)
