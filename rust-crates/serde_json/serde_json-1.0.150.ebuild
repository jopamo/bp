# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="serde_json"
CRATE_VERSION="1.0.150"
CRATE_CHECKSUM="e8014e44b4736ed0538adeecded0fce2a272f22dc9578a7eb6b2d9993c74cfb9"
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
