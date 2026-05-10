# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="memmap2"
CRATE_VERSION="0.9.7"
CRATE_CHECKSUM="483758ad303d734cec05e5c12b41d7e93e6a6390c5e9dae6bdeb7c1259012d28"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross-platform Rust API for memory-mapped file IO"
HOMEPAGE="https://github.com/RazrFalcon/memmap2-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
