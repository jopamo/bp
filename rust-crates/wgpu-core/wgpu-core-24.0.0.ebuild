# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wgpu-core"
CRATE_VERSION="24.0.0"
CRATE_CHECKSUM="82a39b8842dc9ffcbe34346e3ab6d496b32a47f6497e119d762c97fcaae3cb37"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Core implementation logic of wgpu, the cross-platform, safe, pure-rust graphics API"
HOMEPAGE="https://wgpu.rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"api_log_info"
	"counters"
	"dx12"
	"fragile-send-sync-non-atomic-wasm"
	"gles"
	"glsl"
	"indirect-validation"
	"metal"
	"observe_locks"
	"raw-window-handle"
	"renderdoc"
	"replay"
	"resource_log_info"
	"serde"
	"spirv"
	"strict_asserts"
	"trace"
	"vulkan"
	"wgsl"
)
