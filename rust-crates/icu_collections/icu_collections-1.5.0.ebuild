# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="icu_collections"
CRATE_VERSION="1.5.0"
CRATE_CHECKSUM="db2fa452206ebee18c4b5c2274dbf1de17008e874b4dc4f0aea9d01ca79e4526"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Collection of API for use in ICU libraries."
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bench"
	"databake"
	"serde"
	"std"
)
