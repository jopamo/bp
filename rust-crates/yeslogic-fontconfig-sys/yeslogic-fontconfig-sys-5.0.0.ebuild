# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="yeslogic-fontconfig-sys"
CRATE_VERSION="5.0.0"
CRATE_CHECKSUM="ffb6b23999a8b1a997bf47c7bb4d19ad4029c3327bb3386ebe0a5ff584b33c7a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Raw bindings to Fontconfig without a vendored C library"
HOMEPAGE="https://github.com/yeslogic/fontconfig-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"dlopen"
)
