# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hyper-util"
CRATE_VERSION="0.1.17"
CRATE_CHECKSUM="3c6995591a8f1380fcb4ba966a252a4b29188d51d2b89e3a252f5305be65aea8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="hyper utilities"
HOMEPAGE="https://hyper.rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__internal_happy_eyeballs_tests"
	"client"
	"client-legacy"
	"client-proxy"
	"client-proxy-system"
	"default"
	"full"
	"http1"
	"http2"
	"server"
	"server-auto"
	"server-graceful"
	"service"
	"tokio"
	"tracing"
)
