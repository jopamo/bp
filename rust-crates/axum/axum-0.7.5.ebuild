# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="axum"
CRATE_VERSION="0.7.5"
CRATE_CHECKSUM="3a6c9af12842a67734c9a2e355436e5d03b22383ed60cf13cd0c18fbfe3dcbcf"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Web framework that focuses on ergonomics and modularity"
HOMEPAGE="https://github.com/tokio-rs/axum"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
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
