# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="axum-core"
CRATE_VERSION="0.5.6"
CRATE_CHECKSUM="08c78f31d7b1291f7ee735c1c6780ccde7785daae9a9206026862dab7d8792d1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Core types and traits for axum"
HOMEPAGE="https://github.com/tokio-rs/axum"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__private_docs"
	"tracing"
)
