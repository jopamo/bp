# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="psm"
CRATE_VERSION="0.1.21"
CRATE_CHECKSUM="5787f7cda34e3033a72192c018bc5883100330f362ef279a8cbccfce8bb4e874"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Portable Stack Manipulation: stack manipulation and introspection routines"
HOMEPAGE="https://github.com/rust-lang/stacker/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
