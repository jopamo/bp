# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="seize"
CRATE_VERSION="0.5.0"
CRATE_CHECKSUM="e4b8d813387d566f627f3ea1b914c068aac94c40ae27ec43f5f33bde65abefe7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast, efficient, and predictable memory reclamation for concurrent data structures."
HOMEPAGE="https://github.com/ibraheemdev/seize"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"fast-barrier"
)
