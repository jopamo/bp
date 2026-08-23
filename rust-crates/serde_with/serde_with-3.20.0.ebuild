# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="serde_with"
CRATE_VERSION="3.20.0"
CRATE_CHECKSUM="e72c1c2cb7b223fafb600a619537a871c2818583d619401b785e7c0b746ccde2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Custom de/serialization functions for Rust's serde"
HOMEPAGE="https://github.com/jonasbb/serde_with/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"base58"
	"base64"
	"chrono"
	"chrono_0_4"
	"default"
	"guide"
	"hashbrown_0_14"
	"hashbrown_0_15"
	"hashbrown_0_16"
	"hashbrown_0_17"
	"hex"
	"indexmap"
	"indexmap_1"
	"indexmap_2"
	"json"
	"macros"
	"schemars_0_8"
	"schemars_0_9"
	"schemars_1"
	"smallvec_1"
	"std"
	"time_0_3"
)
