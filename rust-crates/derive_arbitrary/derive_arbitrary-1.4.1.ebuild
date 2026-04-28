# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="derive_arbitrary"
CRATE_VERSION="1.4.1"
CRATE_CHECKSUM="30542c1ad912e0e3d22a1935c290e12e8a29d704a420177a31faad4a601a0800"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Derives arbitrary traits"
HOMEPAGE="https://github.com/rust-fuzz/arbitrary"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
