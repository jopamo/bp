# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="icu_locale_core"
CRATE_VERSION="2.0.0"
CRATE_CHECKSUM="0cde2700ccaed3872079a65fb1a78f6c0a36c91570f28755dda67bc8f7d9f00a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="API for managing Unicode Language and Locale Identifiers"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"databake"
	"serde"
	"zerovec"
)
