# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tap"
CRATE_VERSION="1.0.1"
CRATE_CHECKSUM="55937e1799185b12863d447f42597ed69d9928686b8d88a1df17376a097d8369"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generic extensions for tapping values in Rust"
HOMEPAGE="https://github.com/myrrlyn/tap"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
