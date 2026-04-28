# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="matchit"
CRATE_VERSION="0.7.3"
CRATE_CHECKSUM="0e7465ac9959cc2b1404e8e2367b43684a6d13790fe23056cc8c6c5a6b7bcb94"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A high performance, zero-copy URL router."
HOMEPAGE="https://github.com/ibraheemdev/matchit"
LICENSE="MIT BSD-3-Clause"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__test_helpers"
	"default"
)
