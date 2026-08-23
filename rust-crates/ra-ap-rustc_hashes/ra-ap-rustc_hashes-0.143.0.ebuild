# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ra-ap-rustc_hashes"
CRATE_VERSION="0.143.0"
CRATE_CHECKSUM="7df512084c24f4c96c8cc9a59cbd264301efbc8913d3759b065398024af316c9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Automatically published version of the package \`rustc_hashes\` in the rust-lang/rust repository from commit 61cc47e367d7be91e13bcd01e4e96e0e233d4f6d The publishing script for this crate lives at: https://github.com/rust-analyzer/rustc-auto-publish"
HOMEPAGE="https://github.com/rust-lang/rust"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
