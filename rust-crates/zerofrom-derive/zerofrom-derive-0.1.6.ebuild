# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zerofrom-derive"
CRATE_VERSION="0.1.6"
CRATE_CHECKSUM="d71e5d6e06ab090c67b5e44993ec16b72dcbaabc526db883a360057678b48502"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Custom derive for the zerofrom crate"
HOMEPAGE="https://github.com/unicode-org/icu4x"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
