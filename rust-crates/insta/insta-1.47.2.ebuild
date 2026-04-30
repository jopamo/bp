# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="insta"
CRATE_VERSION="1.47.2"
CRATE_CHECKSUM="7b4a6248eb93a4401ed2f37dfe8ea592d3cf05b7cf4f8efa867b6895af7e094e"
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
