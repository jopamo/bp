# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="icu_normalizer"
CRATE_VERSION="2.1.1"
CRATE_CHECKSUM="5f6c8828b67bf8908d82127b2054ea1b4427ff0230ee9141c54251934ab1b599"
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
	"experimental"
	"icu_properties"
	"serde"
	"utf16_iter"
	"utf8_iter"
	"write16"
)
