# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows_x86_64_msvc"
CRATE_VERSION="0.48.5"
CRATE_CHECKSUM="ed94fce61571a4006852b7389a063ab983c02eb1bb37b47f8272ce92d06d9538"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Import lib for Windows"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
