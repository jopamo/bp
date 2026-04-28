# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows_x86_64_msvc"
CRATE_VERSION="0.52.6"
CRATE_CHECKSUM="589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Import lib for Windows"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
