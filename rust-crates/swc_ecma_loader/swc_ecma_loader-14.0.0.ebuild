# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="swc_ecma_loader"
CRATE_VERSION="14.0.0"
CRATE_CHECKSUM="c675d14700c92f12585049b22b02356f1e142f4b0c32a4d0eb4b7a968a4c0c1e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="General ecmascript loader used for transforms"
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cache"
	"default"
	"node"
	"tsc"
)
