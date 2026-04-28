# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wgpu-hal"
CRATE_VERSION="24.0.0"
CRATE_CHECKSUM="5a782e5056b060b0b4010881d1decddd059e44f2ecd01e2db2971b48ad3627e5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Hardware abstraction layer for wgpu, the cross-platform, safe, pure-rust graphics API"
HOMEPAGE="https://wgpu.rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"device_lost_panic"
	"dx12"
	"fragile-send-sync-non-atomic-wasm"
	"gles"
	"internal_error_panic"
	"metal"
	"oom_panic"
	"renderdoc"
	"static-dxc"
	"vulkan"
)
