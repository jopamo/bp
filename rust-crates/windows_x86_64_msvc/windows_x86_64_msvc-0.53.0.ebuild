# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows_x86_64_msvc"
CRATE_VERSION="0.53.0"
CRATE_CHECKSUM="271414315aff87387382ec3d271b52d7ae78726f5d44ac98b4f4030c91880486"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Import lib for Windows"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
