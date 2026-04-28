# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dirs-sys"
CRATE_VERSION="0.4.1"
CRATE_CHECKSUM="520f05a5cbd335fae5a99ff7a6ab8627577660ee5cfd6a94a6a929b52ff0321c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="System-level helper functions for the dirs and directories crates."
HOMEPAGE="https://github.com/dirs-dev/dirs-sys-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
