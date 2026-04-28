# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows-link"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="45e46c0661abb7180e7b9c281db115305d49ca1709ab8242adf09666d2173c65"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Linking for Windows"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
