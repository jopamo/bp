# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows_aarch64_msvc"
CRATE_VERSION="0.53.0"
CRATE_CHECKSUM="c7651a1f62a11b8cbd5e0d42526e55f2c99886c77e007179efff86c2b137e66c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Import lib for Windows"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
