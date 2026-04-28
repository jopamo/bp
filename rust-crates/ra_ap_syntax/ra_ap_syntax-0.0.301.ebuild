# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra_ap_syntax"
CRATE_VERSION="0.0.301"
CRATE_CHECKSUM="6e9e1393281ad5c635239d353ed3cfbf28c8d0af03d0c61a3b24b31d1143b17f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Concrete syntax tree definitions for rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"in-rust-tree"
)
