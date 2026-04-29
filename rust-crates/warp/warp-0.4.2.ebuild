# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="warp"
CRATE_VERSION="0.4.2"
CRATE_CHECKSUM="51d06d9202adc1f15d709c4f4a2069be5428aa912cc025d6f268ac441ab066b0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="serve the web at warp speeds"
HOMEPAGE="https://github.com/seanmonstar/warp"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"compression"
	"compression-brotli"
	"compression-gzip"
	"default"
	"multipart"
	"server"
	"test"
	"websocket"
)
