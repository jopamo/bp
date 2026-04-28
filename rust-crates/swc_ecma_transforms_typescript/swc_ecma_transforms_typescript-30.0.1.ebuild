# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="swc_ecma_transforms_typescript"
CRATE_VERSION="30.0.1"
CRATE_CHECKSUM="3872c006ccfdcc19f1cf5c01c15915a69964ba7982c9f581cdb7e727e77b9a2c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="rust port of babel and closure compiler."
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"concurrent"
)
