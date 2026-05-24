# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="phf"
CRATE_VERSION="0.13.1"
CRATE_CHECKSUM="c1562dc717473dbaa4c1f85a36410e03c047b2e7df7f45ee938fbef64ae7fadf"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Runtime support for perfect hash function data structures"
HOMEPAGE="https://github.com/rust-phf/rust-phf"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"macros"
	"std"
	"uncased"
	"unicase"
)
