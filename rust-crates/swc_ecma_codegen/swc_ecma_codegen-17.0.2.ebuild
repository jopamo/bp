# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="swc_ecma_codegen"
CRATE_VERSION="17.0.2"
CRATE_CHECKSUM="bcf55c2d7555c93f4945e29f93b7529562be97ba16e60dd94c25724d746174ac"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Ecmascript code generator for the swc project."
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"serde-impl"
)
