# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="arrayvec"
CRATE_VERSION="0.7.7"
CRATE_CHECKSUM="f02882884d3e1bc524fb12c79f107f6ad0e1cfd498c536ffb494301740995dfe"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A vector with fixed capacity, backed by an array (it can be stored on the stack too). Implements fixed capacity ArrayVec and ArrayString."
HOMEPAGE="https://github.com/bluss/arrayvec"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
