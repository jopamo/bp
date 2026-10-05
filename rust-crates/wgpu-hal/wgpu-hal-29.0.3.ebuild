# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="wgpu-hal"
CRATE_VERSION="29.0.3"
CRATE_CHECKSUM="31f8e1a9e7a8512f276f7c62e018c7fa8d60954303fed2e5750114332049193f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Hardware abstraction layer for wgpu, the cross-platform, safe, pure-rust graphics API"
HOMEPAGE="https://wgpu.rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"device_lost_panic"
	"dx12"
	"fragile-send-sync-non-atomic-wasm"
	"gles"
	"internal_error_panic"
	"metal"
	"portable-atomic"
	"renderdoc"
	"static-dxc"
	"validation_canary"
	"vulkan"
)
