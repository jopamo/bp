# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="x11-dl"
CRATE_VERSION="2.21.0"
CRATE_CHECKSUM="38735924fedd5314a6e548792904ed8c6de6636285cb9fec04d5b1db85c1516f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="X11 library bindings for Rust"
HOMEPAGE="https://github.com/AltF02/x11-rs.git"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
