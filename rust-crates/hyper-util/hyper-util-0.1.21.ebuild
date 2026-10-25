# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="hyper-util"
CRATE_VERSION="0.1.21"
CRATE_CHECKSUM="ddc03d96684f9226b8a787cdb71488417b53ab5ea8fdb1dac946cb9431cc8bff"
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
	"client-pool"
	"client-proxy"
	"client-proxy-system"
	"default"
	"full"
	"http1"
	"http2"
	"rt-tracing-exec-force"
	"server"
	"server-auto"
	"server-graceful"
	"service"
	"tokio"
	"tracing"
)
