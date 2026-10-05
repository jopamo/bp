# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="suffix_array"
CRATE_VERSION="0.5.0"
CRATE_CHECKSUM="907d9ca9637a22e3a7d7c7818f6105a7898857359e187ad3325d986684b9ec3f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Suffix array construction and searching algorithms for in-memory binary data."
HOMEPAGE="https://github.com/hucsmn/suffix_array"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"pack"
)
