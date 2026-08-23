# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ra_ap_hir"
CRATE_VERSION="0.0.328"
CRATE_CHECKSUM="b77616ef81f690a3eba4befd32112780b99f052676b0e7686a22bf79f3fbe2a8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A high-level object-oriented access to Rust code for rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"in-rust-tree"
)
