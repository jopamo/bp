# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="psm"
CRATE_VERSION="0.1.30"
CRATE_CHECKSUM="3852766467df634d74f0b2d7819bf8dc483a0eb2e3b0f50f756f9cfe8b0d18d8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Portable Stack Manipulation: stack manipulation and introspection routines"
HOMEPAGE="https://github.com/rust-lang/stacker/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
