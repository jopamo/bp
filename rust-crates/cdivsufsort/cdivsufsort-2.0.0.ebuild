# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cdivsufsort"
CRATE_VERSION="2.0.0"
CRATE_CHECKSUM="edefce019197609da416762da75bb000bbd2224b2d89a7e722c2296cbff79b8c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust bindings for Yuta Mori's divsufsort"
HOMEPAGE="https://github.com/fasterthanlime/stringsearch"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"crosscheck"
)
