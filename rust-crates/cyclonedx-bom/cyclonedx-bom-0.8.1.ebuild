# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cyclonedx-bom"
CRATE_VERSION="0.8.1"
CRATE_CHECKSUM="3132b69ba8c13808bd2fa5748ac5b9816eb4f4e1f0bff6b7f9254a5940dcdeef"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="CycloneDX Software Bill of Materials Library"
HOMEPAGE="https://cyclonedx.org/"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
