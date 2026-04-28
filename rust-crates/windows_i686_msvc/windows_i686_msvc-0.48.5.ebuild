# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows_i686_msvc"
CRATE_VERSION="0.48.5"
CRATE_CHECKSUM="8f55c233f70c4b27f66c523580f78f1004e8b5a8b659e05a4eb49d4166cca406"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Import lib for Windows"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
