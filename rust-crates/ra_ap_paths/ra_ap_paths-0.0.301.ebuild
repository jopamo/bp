# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra_ap_paths"
CRATE_VERSION="0.0.301"
CRATE_CHECKSUM="d4991f3d57fac0def7822bebfeb159c8d7b58c824bf82044b765c54f2c0971e2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Path wrappers for absolute and relative paths rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"serde1"
)
