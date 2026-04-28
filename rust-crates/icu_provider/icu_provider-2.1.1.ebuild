# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="icu_provider"
CRATE_VERSION="2.1.1"
CRATE_CHECKSUM="85962cf0ce02e1e0a629cc34e7ca3e373ce20dda4c4d7294bbd0bf1fdb59e614"
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
