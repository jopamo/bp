# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="potential_utf"
CRATE_VERSION="0.1.3"
CRATE_CHECKSUM="84df19adbe5b5a0782edcab45899906947ab039ccf4573713735ee7de1e6b08a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Unvalidated string and character types"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"databake"
	"serde"
	"writeable"
	"zerovec"
)
