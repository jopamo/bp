# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="const-hex"
CRATE_VERSION="1.19.1"
CRATE_CHECKSUM="33e2a781ebdf4467d1428dc4593067825fb646f6871475098d8577421af73558"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast byte array to hex string conversion"
HOMEPAGE="https://github.com/danipopes/const-hex"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__fuzzing"
	"alloc"
	"core-error"
	"default"
	"force-generic"
	"hex"
	"nightly"
	"portable-simd"
	"serde"
	"std"
)
