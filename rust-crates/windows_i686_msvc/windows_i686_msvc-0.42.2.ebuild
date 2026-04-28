# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows_i686_msvc"
CRATE_VERSION="0.42.2"
CRATE_CHECKSUM="44d840b6ec649f480a41c8d80f9c65108b92d89345dd94027bfe06ac444d1060"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Import lib for Windows"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
