# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="smithay-clipboard"
CRATE_VERSION="0.7.2"
CRATE_CHECKSUM="cc8216eec463674a0e90f29e0ae41a4db573ec5b56b1c6c1c71615d249b6d846"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Provides access to the wayland clipboard for client applications."
HOMEPAGE="https://github.com/smithay/smithay-clipboard"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"dlopen"
)
