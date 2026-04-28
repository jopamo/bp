# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="swc_ecma_transforms_base"
CRATE_VERSION="27.0.0"
CRATE_CHECKSUM="6c6f1b8f4232e7a7f614ff7c0f6ccb89c2d028cdf7629f79ad710cff5b28b62c"
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
	"concurrent-renamer"
	"inline-helpers"
)
