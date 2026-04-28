# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="swc_ecma_transforms_optimization"
CRATE_VERSION="29.0.0"
CRATE_CHECKSUM="506bf81408ad780a3f696bb9f84a508d2024c6cd6803d440ededc25be5cee7c8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="rust port of babel and closure compiler."
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"concurrent"
	"debug"
)
