# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra_ap_hir_expand"
CRATE_VERSION="0.0.301"
CRATE_CHECKSUM="97cf8ececb2743a819d8299a408e17f164dd1a1004d65936b3d5493b55330326"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macro expansion for rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"in-rust-tree"
)
