# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="rand_core"
CRATE_VERSION="0.9.5"
CRATE_CHECKSUM="76afc826de14238e6e8c374ddcc1fa19e374fd8dd986b0d2af0d02377261d83c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Core random number generator traits and tools for implementation."
HOMEPAGE="https://rust-random.github.io/book"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"os_rng"
	"serde"
	"std"
)
