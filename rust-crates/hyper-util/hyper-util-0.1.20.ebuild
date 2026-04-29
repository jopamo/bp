# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="hyper-util"
CRATE_VERSION="0.1.20"
CRATE_CHECKSUM="96547c2556ec9d12fb1578c4eaf448b04993e7fb79cbaad930a656880a6bdfa0"
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
	"server"
	"server-auto"
	"server-graceful"
	"service"
	"tokio"
	"tracing"
)
