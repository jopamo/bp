# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="axum"
CRATE_VERSION="0.8.8"
CRATE_CHECKSUM="8b52af3cb4058c895d37317bb27508dccc8e5f2d39454016b297bf4a400597b8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Web framework that focuses on ergonomics and modularity"
HOMEPAGE="https://github.com/tokio-rs/axum"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__private"
	"__private_docs"
	"default"
	"form"
	"http1"
	"http2"
	"json"
	"macros"
	"matched-path"
	"multipart"
	"original-uri"
	"query"
	"tokio"
	"tower-log"
	"tracing"
	"ws"
)
