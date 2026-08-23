# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ra-ap-rustc_next_trait_solver"
CRATE_VERSION="0.143.0"
CRATE_CHECKSUM="10d6f91143011d474bb844d268b0784c6a4c6db57743558b83f5ad34511627f1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Automatically published version of the package \`rustc_next_trait_solver\` in the rust-lang/rust repository from commit 61cc47e367d7be91e13bcd01e4e96e0e233d4f6d The publishing script for this crate lives at: https://github.com/rust-analyzer/rustc-auto-publish"
HOMEPAGE="https://github.com/rust-lang/rust"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"nightly"
)
