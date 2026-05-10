# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="time"
CRATE_VERSION="0.3.44"
CRATE_CHECKSUM="91e7d9e3bb61134e77bde20dd4825b97c010155709965fedf0f49bb138e52a9d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Date and time library. Fully interoperable with the standard library. Mostly compatible with #![no_std]."
HOMEPAGE="https://time-rs.github.io"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"formatting"
	"large-dates"
	"local-offset"
	"macros"
	"parsing"
	"quickcheck"
	"rand"
	"rand08"
	"rand09"
	"serde"
	"serde-human-readable"
	"serde-well-known"
	"std"
	"wasm-bindgen"
)
