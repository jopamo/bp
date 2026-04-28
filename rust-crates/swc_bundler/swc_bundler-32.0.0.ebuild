# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="swc_bundler"
CRATE_VERSION="32.0.0"
CRATE_CHECKSUM="25cf8de492fb6069230a1f217b7becec73eff036d86e4736ff6c1d31017149a3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Very fast ecmascript bundler"
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"concurrent"
	"default"
)
