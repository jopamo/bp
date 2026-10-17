# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="serde_json"
CRATE_VERSION="1.0.154"
CRATE_CHECKSUM="e7e9cc8b1b85264074fbcc02a88680c4096b1e47df8f739dceb03bf482f04bd6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A JSON serialization file format"
HOMEPAGE="https://github.com/serde-rs/json"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"arbitrary_precision"
	"default"
	"float_roundtrip"
	"preserve_order"
	"raw_value"
	"std"
	"unbounded_depth"
)
