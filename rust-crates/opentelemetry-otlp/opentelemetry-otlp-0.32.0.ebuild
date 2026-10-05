# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="opentelemetry-otlp"
CRATE_VERSION="0.32.0"
CRATE_CHECKSUM="9966929966d17620d7c316c643ba62631826e10021409357772d5eea84f62c35"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Exporter for the OpenTelemetry Collector"
HOMEPAGE="https://github.com/open-telemetry/opentelemetry-rust/tree/main/opentelemetry-otlp"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"experimental-grpc-retry"
	"experimental-http-retry"
	"grpc-tonic"
	"gzip-http"
	"gzip-tonic"
	"http-json"
	"http-proto"
	"hyper-client"
	"integration-testing"
	"internal-logs"
	"logs"
	"metrics"
	"reqwest-blocking-client"
	"reqwest-client"
	"reqwest-rustls"
	"reqwest-rustls-webpki-roots"
	"serialize"
	"tls"
	"tls-aws-lc"
	"tls-provider-agnostic"
	"tls-ring"
	"tls-roots"
	"tls-webpki-roots"
	"trace"
	"zstd-http"
	"zstd-tonic"
)
