# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra_ap_syntax-bridge"
CRATE_VERSION="0.0.301"
CRATE_CHECKSUM="684e6ff1008ee5340335888f0453d94bb38950f110059a51f1818c7f6a56a807"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Conversions between syntax nodes and token trees for rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"in-rust-tree"
)
