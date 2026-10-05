# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="swc_ecma_visit"
CRATE_VERSION="18.0.1"
CRATE_CHECKSUM="a9611a72a4008d62608547a394e5d72a5245413104db096d95a52368a8cc1d63"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Visitors for swc ecmascript nodes which works on stable rustc"
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"debug"
	"default"
	"path"
	"serde-impl"
)
