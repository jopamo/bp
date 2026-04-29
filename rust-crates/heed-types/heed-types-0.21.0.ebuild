# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="heed-types"
CRATE_VERSION="0.21.0"
CRATE_CHECKSUM="13c255bdf46e07fb840d120a36dcc81f385140d7191c76a7391672675c01a55d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The types used with the fully typed LMDB wrapper, heed"
HOMEPAGE="https://github.com/Kerollmops/heed"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"arbitrary_precision"
	"default"
	"preserve_order"
	"raw_value"
	"serde-bincode"
	"serde-json"
	"serde-rmp"
	"unbounded_depth"
)
