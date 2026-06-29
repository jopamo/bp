# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="memmap2"
CRATE_VERSION="0.9.11"
CRATE_CHECKSUM="d1219ed1b7f229ee7104d281dd01d6802fe28bb6e95d292942c4daacdeb798c0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross-platform Rust API for memory-mapped file IO"
HOMEPAGE="https://github.com/RazrFalcon/memmap2-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
