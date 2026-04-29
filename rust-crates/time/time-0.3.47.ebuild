# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="time"
CRATE_VERSION="0.3.47"
CRATE_CHECKSUM="743bd48c283afc0388f9b8827b976905fb217ad9e647fae3a379a9283c4def2c"
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
