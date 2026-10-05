# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="divan"
CRATE_VERSION="0.1.21"
CRATE_CHECKSUM="a405457ec78b8fe08b0e32b4a3570ab5dff6dd16eb9e76a5ee0a9d9cbd898933"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Statistically-comfy benchmarking library."
HOMEPAGE="https://github.com/nvzqz/divan"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"dyn_thread_local"
	"help"
	"internal_benches"
	"wrap_help"
)
