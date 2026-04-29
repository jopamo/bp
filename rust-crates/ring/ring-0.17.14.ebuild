# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="ring"
CRATE_VERSION="0.17.14"
CRATE_CHECKSUM="a4689e6c2294d81e88dc6261c768b63bc4fcdb852be6d1352498b114f61383b7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An experiment."
HOMEPAGE="https://github.com/briansmith/ring"
LICENSE="Apache-2.0 ISC"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"dev_urandom_fallback"
	"less-safe-getrandom-custom-or-rdrand"
	"less-safe-getrandom-espidf"
	"slow_tests"
	"std"
	"test_logging"
	"unstable-testing-arm-no-hw"
	"unstable-testing-arm-no-neon"
	"wasm32_unknown_unknown_js"
)
