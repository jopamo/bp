# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra_ap_hir_ty"
CRATE_VERSION="0.0.301"
CRATE_CHECKSUM="bc004e1099ba766a61500c27d34eb5cd336430d0a89a9620315a90d7a202a73a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The type system for rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"in-rust-tree"
)
