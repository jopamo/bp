# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="icu_locid"
CRATE_VERSION="1.5.0"
CRATE_CHECKSUM="13acbb8371917fc971be86fc8057c41a64b521c184808a698c02acc242dbf637"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="API for managing Unicode Language and Locale Identifiers"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"bench"
	"databake"
	"serde"
	"std"
	"zerovec"
)
