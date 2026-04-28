# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows-implement"
CRATE_VERSION="0.58.0"
CRATE_CHECKSUM="2bbd5b46c938e506ecbce286b6628a02171d56153ba733b6c741fc627ec9579b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The implement macro for the windows crate"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
