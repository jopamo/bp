# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra_ap_hir"
CRATE_VERSION="0.0.301"
CRATE_CHECKSUM="ebffdc134eccabc17209d7760cfff7fd12ed18ab6e21188c5e084b97aa38504c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A high-level object-oriented access to Rust code for rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"in-rust-tree"
)
