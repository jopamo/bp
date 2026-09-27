# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ra-ap-rustc_type_ir_macros"
CRATE_VERSION="0.166.0"
CRATE_CHECKSUM="5f4fd2355e2bbf1f343c730f623596efc6e465b5e3685b606a437567ebb75bf8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Automatically published version of the package \`rustc_type_ir_macros\` in the rust-lang/rust repository from commit ce89c898570852a1bb441d77570596e50bf362c2 The publishing script for this crate lives at: https://github.com/rust-analyzer/rustc-auto-publish"
HOMEPAGE="https://github.com/rust-lang/rust"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"nightly"
)
