# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows_x86_64_gnullvm"
CRATE_VERSION="0.53.0"
CRATE_CHECKSUM="0a6e035dd0599267ce1ee132e51c27dd29437f63325753051e71dd9e42406c57"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Import lib for Windows"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
