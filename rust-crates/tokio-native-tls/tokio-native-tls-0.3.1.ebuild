# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="tokio-native-tls"
CRATE_VERSION="0.3.1"
CRATE_CHECKSUM="bbae76ab933c85776efabc971569dd6119c580d8f5d448769dec1764bf796ef2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An implementation of TLS/SSL streams for Tokio using native-tls giving an implementation of TLS for nonblocking I/O streams."
HOMEPAGE="https://tokio.rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"vendored"
)
