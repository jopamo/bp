# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="tonic"
CRATE_VERSION="0.14.5"
CRATE_CHECKSUM="fec7c61a0695dc1887c1b53952990f3ad2e3a31453e1f49f10e75424943a93ec"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A gRPC over HTTP/2 implementation focused on high performance, interoperability, and flexibility."
HOMEPAGE="https://github.com/hyperium/tonic"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"_tls-any"
	"channel"
	"codegen"
	"default"
	"deflate"
	"gzip"
	"router"
	"server"
	"tls-aws-lc"
	"tls-connect-info"
	"tls-native-roots"
	"tls-ring"
	"tls-webpki-roots"
	"transport"
	"zstd"
)
