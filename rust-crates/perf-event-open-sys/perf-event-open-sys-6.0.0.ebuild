# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="perf-event-open-sys"
CRATE_VERSION="6.0.0"
CRATE_CHECKSUM="a5f8d1487a4ffa23c80a1c355dd27235f9b66fb71ba0f261eb417e4fe8451347"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Unsafe, direct bindings for Linux's perf_event_open system call, with associated types and constants."
HOMEPAGE="https://github.com/jimblandy/perf-event.git"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
