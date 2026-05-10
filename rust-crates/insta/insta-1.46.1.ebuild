# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="insta"
CRATE_VERSION="1.46.1"
CRATE_CHECKSUM="248b42847813a1550dafd15296fd9748c651d0c32194559dbc05d804d54b21e8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A snapshot testing library for Rust"
HOMEPAGE="https://insta.rs/"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"_cargo_insta_internal"
	"colors"
	"csv"
	"default"
	"filters"
	"glob"
	"json"
	"redactions"
	"ron"
	"toml"
	"yaml"
)
