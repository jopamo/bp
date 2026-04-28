# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="opentelemetry_sdk"
CRATE_VERSION="0.27.1"
CRATE_CHECKSUM="231e9d6ceef9b0b2546ddf52335785ce41252bc7474ee8ba05bfad277be13ab8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The SDK for the OpenTelemetry metrics collection and distributed tracing framework"
HOMEPAGE="https://github.com/open-telemetry/opentelemetry-rust"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"experimental_metrics_periodic_reader_no_runtime"
	"internal-logs"
	"jaeger_remote_sampler"
	"logs"
	"metrics"
	"rt-async-std"
	"rt-tokio"
	"rt-tokio-current-thread"
	"spec_unstable_logs_enabled"
	"spec_unstable_metrics_views"
	"testing"
	"trace"
)
