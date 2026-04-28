# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="arbitrary"
CRATE_VERSION="1.4.1"
CRATE_CHECKSUM="dde20b3d026af13f561bdd0f15edf01fc734f0dafcedbaf42bba506a9517f223"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The trait for generating structured data from unstructured data"
HOMEPAGE="https://github.com/rust-fuzz/arbitrary/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"derive"
)
