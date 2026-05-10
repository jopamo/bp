# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tokio-macros"
CRATE_VERSION="2.7.0"
CRATE_CHECKSUM="385a6cb71ab9ab790c5fe8d67f1645e6c450a7ce006a33de03daa956cf70a496"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Tokio's proc macros."
HOMEPAGE="https://tokio.rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
