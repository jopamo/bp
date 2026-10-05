# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="sdd"
CRATE_VERSION="4.8.6"
CRATE_CHECKSUM="e5f0e40a01b94e35d1dacbcfbe5bfd3d31e37d9590b2e6d86a82b0e87bd4f551"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Scalable lock-free delayed memory reclaimer"
HOMEPAGE="https://codeberg.org/wvwwvwwv/scalable-delayed-dealloc"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"loom"
)
