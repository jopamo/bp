# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="icu_locale"
CRATE_VERSION="2.0.0"
CRATE_CHECKSUM="6ae5921528335e91da1b6c695dbf1ec37df5ac13faa3f91e5640be93aa2fbefd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="API for Unicode Language and Locale Identifiers canonicalization"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"compiled_data"
	"datagen"
	"default"
	"serde"
)
