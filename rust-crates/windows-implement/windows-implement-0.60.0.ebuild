# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows-implement"
CRATE_VERSION="0.60.0"
CRATE_CHECKSUM="a47fddd13af08290e67f4acabf4b459f647552718f683a7b415d290ac744a836"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The implement macro for the windows crate"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
