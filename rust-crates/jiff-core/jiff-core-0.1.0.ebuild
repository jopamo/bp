# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="jiff-core"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="7feca88439efe53da3754500c1851dedf3cb36c524dd5cf8225cc0794de95d09"
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
	"default"
	"defmt"
	"logging"
	"std"
	"tz-fat"
)
