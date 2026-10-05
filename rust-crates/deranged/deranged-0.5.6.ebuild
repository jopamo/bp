# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="deranged"
CRATE_VERSION="0.5.6"
CRATE_CHECKSUM="cc3dc5ad92c2e2d1c193bbbbdf2ea477cb81331de4f3103f267ca18368b988c4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Ranged integers"
HOMEPAGE="https://github.com/jhpratt/deranged"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"macros"
	"num"
	"powerfmt"
	"quickcheck"
	"rand"
	"rand010"
	"rand08"
	"rand09"
	"serde"
)
