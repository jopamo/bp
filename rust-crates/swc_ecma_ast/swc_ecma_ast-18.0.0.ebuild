# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="swc_ecma_ast"
CRATE_VERSION="18.0.0"
CRATE_CHECKSUM="a573a0c72850dec8d4d8085f152d5778af35a2520c3093b242d2d1d50776da7c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Ecmascript ast."
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__rkyv"
	"default"
	"encoding-impl"
	"fuzzing"
	"rkyv-impl"
	"serde-impl"
	"shrink-to-fit"
)
