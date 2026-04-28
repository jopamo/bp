# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="scc"
CRATE_VERSION="2.4.0"
CRATE_CHECKSUM="46e6f046b7fef48e2660c57ed794263155d713de679057f2d0c169bfc6e756cc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="High-performance containers and utilities for concurrent and asynchronous programming"
HOMEPAGE="https://github.com/wvwwvwwv/scalable-concurrent-containers/"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"loom"
)
