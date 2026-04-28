# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="env_home"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="c7f84e12ccf0a7ddc17a6c41c93326024c42920d7ee630d04950e6926645c0fe"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Get the user home directory in a cross-platform way."
HOMEPAGE="https://github.com/notpeter/env-home"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
