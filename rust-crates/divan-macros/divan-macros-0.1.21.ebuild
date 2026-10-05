# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="divan-macros"
CRATE_VERSION="0.1.21"
CRATE_CHECKSUM="9556bc800956545d6420a640173e5ba7dfa82f38d3ea5a167eb555bc69ac3323"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macros for Divan, a statistically-comfy benchmarking library."
HOMEPAGE="https://github.com/nvzqz/divan"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
