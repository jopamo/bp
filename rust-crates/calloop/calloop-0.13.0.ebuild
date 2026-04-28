# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="calloop"
CRATE_VERSION="0.13.0"
CRATE_CHECKSUM="b99da2f8558ca23c71f4fd15dc57c906239752dd27ff3c00a1d56b685b7cbfec"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A callback-based event loop"
HOMEPAGE="https://github.com/Smithay/calloop"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"block_on"
	"executor"
	"nightly_coverage"
	"signals"
)
