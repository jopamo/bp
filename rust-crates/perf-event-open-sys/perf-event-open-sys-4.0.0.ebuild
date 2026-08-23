# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="perf-event-open-sys"
CRATE_VERSION="4.0.0"
CRATE_CHECKSUM="7c44fb1c7651a45a3652c4afc6e754e40b3d6e6556f1487e2b230bfc4f33c2a8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Unsafe, direct bindings for Linux's perf_event_open system call, with associated types and constants."
HOMEPAGE="https://github.com/jimblandy/perf-event-open-sys.git"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
