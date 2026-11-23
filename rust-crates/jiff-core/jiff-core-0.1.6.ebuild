# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="jiff-core"
CRATE_VERSION="0.1.6"
CRATE_CHECKSUM="48e9635854583b49ce3c6c43a071f70b0a49e79ad3c261c7b3aa76b2280416d2"
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
