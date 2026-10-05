# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="wgpu-core"
CRATE_VERSION="29.0.1"
CRATE_CHECKSUM="1e80ac6cf1895df6342f87d975162108f9d98772a0d74bc404ab7304ac29469e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Core implementation logic of wgpu, the cross-platform, safe, pure-rust graphics API"
HOMEPAGE="https://wgpu.rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"angle"
	"api_log_info"
	"counters"
	"default"
	"dx12"
	"fragile-send-sync-non-atomic-wasm"
	"gles"
	"glsl"
	"metal"
	"noop"
	"observe_locks"
	"portable-atomic"
	"renderdoc"
	"replay"
	"resource_log_info"
	"serde"
	"spirv"
	"static-dxc"
	"std"
	"strict_asserts"
	"trace"
	"vulkan"
	"vulkan-portability"
	"webgl"
	"wgsl"
)
