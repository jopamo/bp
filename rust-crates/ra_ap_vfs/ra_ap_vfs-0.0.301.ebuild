# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra_ap_vfs"
CRATE_VERSION="0.0.301"
CRATE_CHECKSUM="6c174d6b9b7a7f54687df7e00c3e75ed6f082a7943a9afb1d54f33c0c12773de"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A virtual file system for rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
