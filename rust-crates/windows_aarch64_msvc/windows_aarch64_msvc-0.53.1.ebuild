# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows_aarch64_msvc"
CRATE_VERSION="0.53.1"
CRATE_CHECKSUM="b9d782e804c2f632e395708e99a94275910eb9100b2114651e04744e9b125006"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Import lib for Windows"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
