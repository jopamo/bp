# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="gpu-allocator"
CRATE_VERSION="0.27.0"
CRATE_CHECKSUM="c151a2a5ef800297b4e79efa4f4bec035c5f51d5ae587287c9b952bdf734cacd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Memory allocator for GPU memory in Vulkan and DirectX 12"
HOMEPAGE="https://github.com/Traverse-Research/gpu-allocator"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"d3d12"
	"default"
	"metal"
	"public-winapi"
	"visualizer"
	"vulkan"
)
