# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra_ap_tt"
CRATE_VERSION="0.0.301"
CRATE_CHECKSUM="fb87c7b35572c18a580ea811e970b94875fad5ac7cfa8644266a59081044f959"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A `TokenTree` data structure for rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"in-rust-tree"
)
