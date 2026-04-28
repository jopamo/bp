# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows_i686_msvc"
CRATE_VERSION="0.52.6"
CRATE_CHECKSUM="240948bc05c5e7c6dabba28bf89d89ffce3e303022809e73deaefe4f6ec56c66"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Import lib for Windows"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
