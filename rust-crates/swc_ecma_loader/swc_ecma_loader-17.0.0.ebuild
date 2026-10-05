# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="swc_ecma_loader"
CRATE_VERSION="17.0.0"
CRATE_CHECKSUM="fbcababb48f0d46587a0a854b2c577eb3a56fa99687de558338021e93cd2c8f5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="General ecmascript loader used for transforms"
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cache"
	"default"
	"node"
	"tsc"
)
