# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="jiter"
CRATE_VERSION="0.16.0"
CRATE_CHECKSUM="820ddcacd75c9782308d3fa594f3885630ea3f49adba78a8a29abdfe4b81630c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast Iterable JSON parser"
HOMEPAGE="https://github.com/pydantic/jiter/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"num-bigint"
	"python"
	"serde"
)
