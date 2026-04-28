# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="thiserror"
CRATE_VERSION="2.0.12"
CRATE_CHECKSUM="567b8a2dae586314f7be2a752ec7474332959c6460e02bde30d702a66d488708"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="derive(Error)"
HOMEPAGE="https://github.com/dtolnay/thiserror"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
