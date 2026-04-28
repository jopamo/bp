# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows_x86_64_gnu"
CRATE_VERSION="0.48.5"
CRATE_CHECKSUM="53d40abd2583d23e4718fddf1ebec84dbff8381c07cae67ff7768bbf19c6718e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Import lib for Windows"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
