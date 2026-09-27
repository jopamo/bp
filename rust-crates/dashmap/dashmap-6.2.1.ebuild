# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="dashmap"
CRATE_VERSION="6.2.1"
CRATE_CHECKSUM="e6361d5c062261c78a176addb82d4c821ae42bed6089de0e12603cd25de2059c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Blazing fast concurrent HashMap for Rust."
HOMEPAGE="https://github.com/xacrimon/dashmap"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"inline"
	"raw-api"
	"typesize"
)
