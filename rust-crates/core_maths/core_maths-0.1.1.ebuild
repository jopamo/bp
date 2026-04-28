# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="core_maths"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="77745e017f5edba1a9c1d854f6f3a52dac8a12dd5af5d2f54aecf61e43d80d30"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Extension trait for full float functionality in `#[no_std]` backed by `libm`."
HOMEPAGE="https://github.com/robertbastian/core_maths"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
