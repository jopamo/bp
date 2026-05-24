# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tree-sitter-python"
CRATE_VERSION="0.23.6"
CRATE_CHECKSUM="3d065aaa27f3aaceaf60c1f0e0ac09e1cb9eb8ed28e7bcdaa52129cffc7f4b04"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Python grammar for tree-sitter"
HOMEPAGE="https://github.com/tree-sitter/tree-sitter-python"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
