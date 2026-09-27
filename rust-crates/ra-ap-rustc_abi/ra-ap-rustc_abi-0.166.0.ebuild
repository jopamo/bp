# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ra-ap-rustc_abi"
CRATE_VERSION="0.166.0"
CRATE_CHECKSUM="e2cf1b1ffe31b6226c00b40cddfda65002b7729f9f4ed2d547b5856cdab0011c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Automatically published version of the package \`rustc_abi\` in the rust-lang/rust repository from commit ce89c898570852a1bb441d77570596e50bf362c2 The publishing script for this crate lives at: https://github.com/rust-analyzer/rustc-auto-publish"
HOMEPAGE="https://github.com/rust-lang/rust"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"nightly"
)
