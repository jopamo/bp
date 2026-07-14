# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rand_xorshift"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="513962919efc330f829edb2535844d1b912b0fbe2ca165d613e4e8788bb05a5a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Xorshift random number generator"
HOMEPAGE="https://rust-random.github.io/book"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"serde"
)
