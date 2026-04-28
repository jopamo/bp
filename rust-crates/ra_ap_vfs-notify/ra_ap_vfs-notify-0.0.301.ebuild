# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra_ap_vfs-notify"
CRATE_VERSION="0.0.301"
CRATE_CHECKSUM="04f6fce8d47c7ce9b8f2cd0e5a55f8fc4878d6043e61f46cde4391d3a5c6086f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation of `loader::Handle` for rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
