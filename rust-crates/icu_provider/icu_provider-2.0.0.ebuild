# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="icu_provider"
CRATE_VERSION="2.0.0"
CRATE_CHECKSUM="03c80da27b5f4187909049ee2d72f276f0d9f99a42c306bd0131ecfe04d8e5af"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Trait and struct definitions for the ICU data provider"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

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
)
