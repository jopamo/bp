# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="crossterm_winapi"
CRATE_VERSION="0.9.1"
CRATE_CHECKSUM="acdd7c62a3665c7f6830a51635d9ac9b23ed385797f70a83bb8bafe9c572ab2b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="WinAPI wrapper that provides some basic simple abstractions around common WinAPI calls"
HOMEPAGE="https://github.com/crossterm-rs/crossterm-winapi"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
