# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="jiff-core"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="5e52fe76043ccecc9005d2305ebaadf7d7fc0cc89ca6baa10a94d6bc68c7128c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Low level datetime primitives for the Jiff library."
HOMEPAGE="https://github.com/BurntSushi/jiff/tree/master/crates/jiff-core"
LICENSE="|| ( Unlicense MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"arbitrary"
	"default"
	"defmt"
	"logging"
	"std"
	"tz-fat"
)
