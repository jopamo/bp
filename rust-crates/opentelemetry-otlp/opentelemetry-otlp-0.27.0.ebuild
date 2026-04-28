# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="opentelemetry-otlp"
CRATE_VERSION="0.27.0"
CRATE_CHECKSUM="91cf61a1868dacc576bf2b2a1c3e9ab150af7272909e80085c3173384fe11f76"
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
	"grpc-tonic"
	"gzip-tonic"
	"http-json"
	"http-proto"
	"hyper-client"
	"integration-testing"
	"internal-logs"
	"logs"
	"metrics"
	"populate-logs-event-name"
	"reqwest-blocking-client"
	"reqwest-client"
	"reqwest-rustls"
	"reqwest-rustls-webpki-roots"
	"serialize"
	"tls"
	"tls-roots"
	"tls-webpki-roots"
	"trace"
	"zstd-tonic"
)
