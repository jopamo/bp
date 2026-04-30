# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zerovec"
CRATE_VERSION="0.11.6"
CRATE_CHECKSUM="90f911cbc359ab6af17377d242225f4d75119aec87ea711a880987b18cd7b239"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Zero-copy vector backed by a byte array"
HOMEPAGE="https://github.com/unicode-org/icu4x"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"databake"
	"derive"
	"hashmap"
	"schemars"
	"serde"
	"std"
	"yoke"
)
