# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="scroll_derive"
CRATE_VERSION="0.13.0"
CRATE_CHECKSUM="22fc4f90c27b57691bbaf11d8ecc7cfbfe98a4da6dbe60226115d322aa80c06e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A macros 1.1 derive implementation for Pread and Pwrite traits from the scroll crate"
HOMEPAGE="https://github.com/m4b/scroll"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
