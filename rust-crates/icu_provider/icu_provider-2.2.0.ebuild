# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="icu_provider"
CRATE_VERSION="2.2.0"
CRATE_CHECKSUM="139c4cf31c8b5f33d7e199446eff9c1e02decfc2f0eec2c8d71f65befa45b421"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Trait and struct definitions for the ICU data provider"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"baked"
	"deserialize_bincode_1"
	"deserialize_json"
	"deserialize_postcard_1"
	"export"
	"logging"
	"serde"
	"std"
	"sync"
	"zerotrie"
)
