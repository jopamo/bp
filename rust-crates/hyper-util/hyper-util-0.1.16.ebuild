# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="hyper-util"
CRATE_VERSION="0.1.16"
CRATE_CHECKSUM="8d9b05277c7e8da2c93a568989bb6207bef0112e8d17df7a6eda4a3cf143bc5e"
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
