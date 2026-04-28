# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra_ap_intern"
CRATE_VERSION="0.0.301"
CRATE_CHECKSUM="14586c2c4781b69fdd0c505972d9bff8c162a8740537a3ee506faff686d9a20d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Global `Arc`-based object interning infrastructure for rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
