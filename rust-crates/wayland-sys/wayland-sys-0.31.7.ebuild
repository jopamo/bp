# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wayland-sys"
CRATE_VERSION="0.31.7"
CRATE_CHECKSUM="34949b42822155826b41db8e5d0c1be3a2bd296c747577a43a3e6daefc296142"
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
	"server"
)
