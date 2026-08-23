# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="perf-event"
CRATE_VERSION="0.4.8"
CRATE_CHECKSUM="b4d6393d9238342159080d79b78cb59c67399a8e7ecfa5d410bd614169e4e823"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust interface to Linux performance monitoring"
HOMEPAGE="https://github.com/jimblandy/perf-event.git"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"hooks"
)
