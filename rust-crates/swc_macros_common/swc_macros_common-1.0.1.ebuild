# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="swc_macros_common"
CRATE_VERSION="1.0.1"
CRATE_CHECKSUM="aae1efbaa74943dc5ad2a2fb16cbd78b77d7e4d63188f3c5b4df2b4dcd2faaae"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Common utilities for swc macros."
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
