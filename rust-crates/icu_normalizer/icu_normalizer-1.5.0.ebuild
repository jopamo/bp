# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="icu_normalizer"
CRATE_VERSION="1.5.0"
CRATE_CHECKSUM="19ce3e0da2ec68599d193c93d088142efd7f9c5d6fc9b803774855747dc6a84f"
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
	"serde"
	"std"
)
