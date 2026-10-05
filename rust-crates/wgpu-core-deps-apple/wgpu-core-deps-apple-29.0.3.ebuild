# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="wgpu-core-deps-apple"
CRATE_VERSION="29.0.3"
CRATE_CHECKSUM="62e51b5447e144b3dbba4feb01f80f4fa21696fa0cd99afb2c3df1affd6fdb28"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Feature unification helper crate for Apple platforms"
HOMEPAGE="https://wgpu.rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"angle"
	"metal"
	"vulkan-portability"
)
