# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows_i686_gnullvm"
CRATE_VERSION="0.53.1"
CRATE_CHECKSUM="fa7359d10048f68ab8b09fa71c3daccfb0e9b559aed648a8f95469c27057180c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Import lib for Windows"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
