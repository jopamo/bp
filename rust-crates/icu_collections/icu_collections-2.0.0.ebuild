# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="icu_collections"
CRATE_VERSION="2.0.0"
CRATE_CHECKSUM="200072f5d0e3614556f94a9930d5dc3e0662a652823904c3a75dc3b0af7fee47"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Collection of API for use in ICU libraries."
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"databake"
	"serde"
)
