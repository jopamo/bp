# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="jiter"
CRATE_VERSION="0.18.0"
CRATE_CHECKSUM="49e31424b61d85292bd805dbf643c3ccc44f5f3871fb751209b889ee70585029"
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
