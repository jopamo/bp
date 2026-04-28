# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="axum-core"
CRATE_VERSION="0.4.5"
CRATE_CHECKSUM="09f2bd6146b97ae3359fa0cc6d6b376d9539582c7b4220f041a33ec24c226199"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Core types and traits for axum"
HOMEPAGE="https://github.com/tokio-rs/axum"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__private_docs"
	"tracing"
)
