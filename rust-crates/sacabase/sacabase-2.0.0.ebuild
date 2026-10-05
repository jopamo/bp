# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="sacabase"
CRATE_VERSION="2.0.0"
CRATE_CHECKSUM="9883fc3d6ce3d78bb54d908602f8bc1f7b5f983afe601dabe083009d86267a84"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Base types and functions for suffix arrays and longest substring search"
HOMEPAGE="https://github.com/fasterthanlime/stringsearch"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
