# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dirs-sys"
CRATE_VERSION="0.5.0"
CRATE_CHECKSUM="e01a3366d27ee9890022452ee61b2b63a67e6f13f58900b651ff5665f0bb1fab"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="System-level helper functions for the dirs and directories crates."
HOMEPAGE="https://github.com/dirs-dev/dirs-sys-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
