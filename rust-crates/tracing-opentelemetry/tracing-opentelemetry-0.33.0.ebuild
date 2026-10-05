# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tracing-opentelemetry"
CRATE_VERSION="0.33.0"
CRATE_CHECKSUM="adbc64cba7137545b8044cb1fe9814f7aacf3c6b5f9b45be8bb5db538befdb26"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="OpenTelemetry integration for tracing"
HOMEPAGE="https://github.com/tokio-rs/tracing-opentelemetry"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"metrics"
)
