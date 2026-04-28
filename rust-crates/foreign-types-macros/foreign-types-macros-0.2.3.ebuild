# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="foreign-types-macros"
CRATE_VERSION="0.2.3"
CRATE_CHECKSUM="1a5c6c585bc94aaf2c7b51dd4c2ba22680844aba4c687be581871a6f518c5742"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An internal crate used by foreign-types"
HOMEPAGE="https://github.com/sfackler/foreign-types"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"std"
)
