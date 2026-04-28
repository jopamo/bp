# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wayland-csd-frame"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="625c5029dbd43d25e6aa9615e88b829a5cad13b2819c4ae129fdbb7c31ab4c7e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Common trait and types for wayland CSD interop"
HOMEPAGE="https://github.com/rust-windowing/wayland-csd-frame"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
