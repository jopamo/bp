# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wayland-scanner"
CRATE_VERSION="0.31.7"
CRATE_CHECKSUM="54cb1e9dc49da91950bdfd8b848c49330536d9d1fb03d4bfec8cae50caa50ae3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Wayland Scanner for generating rust APIs from XML wayland protocol files."
HOMEPAGE="https://github.com/smithay/wayland-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
