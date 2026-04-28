# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="icu_locid_transform"
CRATE_VERSION="1.5.0"
CRATE_CHECKSUM="01d11ac35de8e40fdeda00d9e1e9d92525f3f9d887cdd7aa81d727596788b54e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="API for Unicode Language and Locale Identifiers canonicalization"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bench"
	"compiled_data"
	"datagen"
	"default"
	"serde"
	"std"
)
