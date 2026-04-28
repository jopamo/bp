# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="perf-event-open-sys"
CRATE_VERSION="1.0.1"
CRATE_CHECKSUM="ce9bedf5da2c234fdf2391ede2b90fabf585355f33100689bc364a3ea558561a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Unsafe, direct bindings for Linux's perf_event_open system call, with associated types and constants."
HOMEPAGE="https://github.com/jimblandy/perf-event-open-sys.git"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
