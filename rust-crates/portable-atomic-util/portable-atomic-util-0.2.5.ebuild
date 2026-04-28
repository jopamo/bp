# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="portable-atomic-util"
CRATE_VERSION="0.2.5"
CRATE_CHECKSUM="7a9db96d7fa8782dd8c15ce32ffe8680bbd1e978a43bf51a34d39483540495f5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Synchronization primitives built with portable-atomic."
HOMEPAGE="https://github.com/taiki-e/portable-atomic"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
