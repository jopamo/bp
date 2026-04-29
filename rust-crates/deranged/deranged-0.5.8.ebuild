# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="deranged"
CRATE_VERSION="0.5.8"
CRATE_CHECKSUM="7cd812cc2bc1d69d4764bd80df88b4317eaef9e773c75226407d9bc0876b211c"
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
