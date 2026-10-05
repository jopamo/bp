# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="icu_collator"
CRATE_VERSION="2.2.1"
CRATE_CHECKSUM="8bbdf98e5e0aa827770acee171ebb568aaab975a36b56afdb5fd0e2f525750bb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="API for comparing strings according to language-dependent conventions"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"compiled_data"
	"datagen"
	"default"
	"latin1"
	"serde"
	"unstable"
)
