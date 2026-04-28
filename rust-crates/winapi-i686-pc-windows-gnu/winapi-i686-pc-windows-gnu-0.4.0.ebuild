# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="winapi-i686-pc-windows-gnu"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Import libraries for the i686-pc-windows-gnu target. Please don't use this crate directly, depend on winapi instead."
HOMEPAGE="https://github.com/retep998/winapi-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
