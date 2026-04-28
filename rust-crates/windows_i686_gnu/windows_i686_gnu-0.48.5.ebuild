# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows_i686_gnu"
CRATE_VERSION="0.48.5"
CRATE_CHECKSUM="a75915e7def60c94dcef72200b9a8e58e5091744960da64ec734a6c6e9b3743e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Import lib for Windows"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
