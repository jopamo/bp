# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="icu_provider"
CRATE_VERSION="1.5.0"
CRATE_CHECKSUM="6ed421c8a8ef78d3e2dbc98a973be2f3770cb42b606e3ab18d6237c4dfde68d9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Trait and struct definitions for the ICU data provider"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bench"
	"datagen"
	"deserialize_bincode_1"
	"deserialize_json"
	"deserialize_postcard_1"
	"experimental"
	"log_error_context"
	"logging"
	"macros"
	"serde"
	"std"
	"sync"
)
