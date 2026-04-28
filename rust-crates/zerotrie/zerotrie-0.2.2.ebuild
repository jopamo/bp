# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zerotrie"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="36f0bbd478583f79edad978b407914f61b2972f5af6fa089686016be8f9af595"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A data structure that efficiently maps strings to integers"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"databake"
	"default"
	"litemap"
	"serde"
	"yoke"
	"zerofrom"
)
