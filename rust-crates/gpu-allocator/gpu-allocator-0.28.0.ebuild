# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="gpu-allocator"
CRATE_VERSION="0.28.0"
CRATE_CHECKSUM="51255ea7cfaadb6c5f1528d43e92a82acb2b96c43365989a28b2d44ee38f8795"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Memory allocator for GPU memory in Vulkan and DirectX 12"
HOMEPAGE="https://github.com/Traverse-Research/gpu-allocator"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"d3d12"
	"default"
	"hashbrown"
	"metal"
	"std"
	"visualizer"
	"vulkan"
)
