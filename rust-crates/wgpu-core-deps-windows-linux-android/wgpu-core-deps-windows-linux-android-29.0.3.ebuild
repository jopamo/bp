# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="wgpu-core-deps-windows-linux-android"
CRATE_VERSION="29.0.3"
CRATE_CHECKSUM="1bfb01076d0aa08b0ba9bd741e178b5cc440f5abe99d9581323a4c8b5d1a1916"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Feature unification helper crate for the Windows/Linux/Android platforms"
HOMEPAGE="https://wgpu.rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"dx12"
	"gles"
	"renderdoc"
	"vulkan"
)
