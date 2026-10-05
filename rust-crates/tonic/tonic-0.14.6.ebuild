# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tonic"
CRATE_VERSION="0.14.6"
CRATE_CHECKSUM="ac2a5518c70fa84342385732db33fb3f44bc4cc748936eb5833d2df34d6445ef"
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
