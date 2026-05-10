# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tracing-durations-export"
CRATE_VERSION="0.3.1"
CRATE_CHECKSUM="32e0c2cfee378f62291f2703bbb949b99213306c2729fe977799653c3c3404b5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Record and visualize parallelism of tracing spans"
HOMEPAGE="https://github.com/konstin/tracing-durations-export"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cli"
	"plot"
)
