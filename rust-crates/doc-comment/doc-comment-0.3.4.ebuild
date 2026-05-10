# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="doc-comment"
CRATE_VERSION="0.3.4"
CRATE_CHECKSUM="780955b8b195a21ab8e4ac6b60dd1dbdcec1dc6c51c0617964b08c81785e12c9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macro to generate doc comments"
HOMEPAGE="https://github.com/GuillaumeGomez/doc-comment"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"no_core"
	"old_macros"
)
