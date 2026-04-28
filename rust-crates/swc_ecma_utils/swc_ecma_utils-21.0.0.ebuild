# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="swc_ecma_utils"
CRATE_VERSION="21.0.0"
CRATE_CHECKSUM="83259addd99ed4022aa9fc4d39428c008d3d42533769e1a005529da18cde4568"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Utilities for swc ecmascript ast nodes"
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"concurrent"
)
