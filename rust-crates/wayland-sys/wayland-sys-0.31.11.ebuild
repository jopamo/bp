# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="wayland-sys"
CRATE_VERSION="0.31.11"
CRATE_CHECKSUM="d8eab23fefc9e41f8e841df4a9c707e8a8c4ed26e944ef69297184de2785e3be"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="FFI bindings to the various libwayland-*.so libraries. You should only need this crate if you are working on custom wayland protocol extensions. Look at the crate wayland-client for usable bindings."
HOMEPAGE="https://github.com/smithay/wayland-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"client"
	"cursor"
	"dlopen"
	"egl"
	"libwayland_client_1_23"
	"libwayland_server_1_22"
	"libwayland_server_1_23"
	"server"
)
