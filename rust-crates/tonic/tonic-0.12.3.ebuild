# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tonic"
CRATE_VERSION="0.12.3"
CRATE_CHECKSUM="877c5b330756d856ffcc4553ab34a5684481ade925ecc54bcd1bf02b1d0d4d52"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A gRPC over HTTP/2 implementation focused on high performance, interoperability, and flexibility."
HOMEPAGE="https://github.com/hyperium/tonic"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"channel"
	"codegen"
	"default"
	"gzip"
	"prost"
	"router"
	"server"
	"tls"
	"tls-native-roots"
	"tls-roots"
	"tls-webpki-roots"
	"transport"
	"zstd"
)
