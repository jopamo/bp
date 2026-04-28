# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows_x86_64_gnu"
CRATE_VERSION="0.42.2"
CRATE_CHECKSUM="8de912b8b8feb55c064867cf047dda097f92d51efad5b491dfb98f6bbb70cb36"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Import lib for Windows"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
