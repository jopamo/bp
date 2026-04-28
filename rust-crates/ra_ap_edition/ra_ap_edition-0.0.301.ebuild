# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra_ap_edition"
CRATE_VERSION="0.0.301"
CRATE_CHECKSUM="1bdc6cbe42c63ca78611bae82bfc8db24864f33dccc813697c5fde43a0907285"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust edition support crate for rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
