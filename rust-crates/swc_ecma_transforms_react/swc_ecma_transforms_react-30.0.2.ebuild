# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="swc_ecma_transforms_react"
CRATE_VERSION="30.0.2"
CRATE_CHECKSUM="69ea0052ac23b5b9fbc85bbdb1791b36b918f9d55f594b0ed8e25babb4c32d16"
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
	"default"
	"serde-impl"
)
