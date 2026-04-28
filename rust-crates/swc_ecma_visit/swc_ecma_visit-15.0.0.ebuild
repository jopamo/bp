# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="swc_ecma_visit"
CRATE_VERSION="15.0.0"
CRATE_CHECKSUM="75a579aa8f9e212af521588df720ccead079c09fe5c8f61007cf724324aed3a0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Visitors for swc ecmascript nodes which works on stable rustc"
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"debug"
	"default"
	"path"
	"serde-impl"
)
