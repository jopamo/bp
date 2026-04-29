# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="icu_locale_core"
CRATE_VERSION="2.1.1"
CRATE_CHECKSUM="edba7861004dd3714265b4db54a3c390e880ab658fec5f7db895fae2046b5bb6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="API for managing Unicode Language and Locale Identifiers"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"databake"
	"serde"
	"zerovec"
)
