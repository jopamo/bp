# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra_ap_profile"
CRATE_VERSION="0.0.301"
CRATE_CHECKSUM="19981637b8ee4160e228c815a7fef3944b5c0555d6af41a931be92d68978bc6c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A collection of tools for profiling rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cpu_profiler"
	"jemalloc"
)
