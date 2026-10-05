# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="bsdiff"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="b6709158fe6ca66c1f32eb27b4ae5997c67b0df350ae185831233af3e7a91213"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust port of the bsdiff binary diffing algorithm."
HOMEPAGE="https://lib.rs/bsdiff"
LICENSE="BSD-2-Clause"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
