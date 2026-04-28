# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows_i686_gnu"
CRATE_VERSION="0.42.2"
CRATE_CHECKSUM="c61d927d8da41da96a81f029489353e68739737d3beca43145c8afec9a31a84f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Import lib for Windows"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
