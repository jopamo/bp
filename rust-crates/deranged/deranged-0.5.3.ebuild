# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deranged"
CRATE_VERSION="0.5.3"
CRATE_CHECKSUM="d630bccd429a5bb5a64b5e94f693bfc48c9f8566418fda4c494cc94f911f87cc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Ranged integers"
HOMEPAGE="https://github.com/jhpratt/deranged"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"macros"
	"num"
	"powerfmt"
	"quickcheck"
	"rand"
	"rand08"
	"rand09"
	"serde"
)
