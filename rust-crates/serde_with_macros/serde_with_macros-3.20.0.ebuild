# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="serde_with_macros"
CRATE_VERSION="3.20.0"
CRATE_CHECKSUM="b90c488738ecb4fb0262f41f43bc40efc5868d9fb744319ddf5f5317f417bfac"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="proc-macro library for serde_with"
HOMEPAGE="https://github.com/jonasbb/serde_with/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"schemars_0_8"
	"schemars_0_9"
	"schemars_1"
)
