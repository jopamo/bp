# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows-interface"
CRATE_VERSION="0.59.3"
CRATE_CHECKSUM="3f316c4a2570ba26bbec722032c4099d8c8bc095efccdc15688708623367e358"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The interface macro for the Windows crates"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
