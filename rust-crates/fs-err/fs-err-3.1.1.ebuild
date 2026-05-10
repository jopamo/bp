# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="fs-err"
CRATE_VERSION="3.1.1"
CRATE_CHECKSUM="88d7be93788013f265201256d58f04936a8079ad5dc898743aa20525f503b683"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A drop-in replacement for std::fs with more helpful error messages."
HOMEPAGE="https://github.com/andrewhickman/fs-err"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"expose_original_error"
)
