# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="semver-parser"
CRATE_VERSION="0.7.0"
CRATE_CHECKSUM="388a1df253eca08550bef6c72392cfe7c30914bf41df5269b68cbd6ff8f570a3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parsing of the semver spec."
HOMEPAGE="https://github.com/steveklabnik/semver-parser"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
