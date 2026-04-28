# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra_ap_mbe"
CRATE_VERSION="0.0.301"
CRATE_CHECKSUM="67333c6405797cb64aafb994b9a179157b30beeda2352e203e800be2b184a22d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Handling of `macro_rules` macros for rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"in-rust-tree"
)
