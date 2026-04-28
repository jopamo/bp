# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tracing-opentelemetry"
CRATE_VERSION="0.28.0"
CRATE_CHECKSUM="97a971f6058498b5c0f1affa23e7ea202057a7301dbff68e968b2d578bcbd053"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="OpenTelemetry integration for tracing"
HOMEPAGE="https://github.com/tokio-rs/tracing-opentelemetry"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"metrics"
	"metrics_gauge_unstable"
)
