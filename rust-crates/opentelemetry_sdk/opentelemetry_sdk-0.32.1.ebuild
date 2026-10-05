# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="opentelemetry_sdk"
CRATE_VERSION="0.32.1"
CRATE_CHECKSUM="9b59f80e1ac4d5ff7a2db8fb6c80badb7f0f3f858211fba08dd9aaec750894f9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The SDK for the OpenTelemetry metrics collection and distributed tracing framework"
HOMEPAGE="https://github.com/open-telemetry/opentelemetry-rust/tree/main/opentelemetry-sdk"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bench_profiling"
	"default"
	"experimental_async_runtime"
	"experimental_logs_batch_log_processor_with_async_runtime"
	"experimental_metrics_bound_instruments"
	"experimental_metrics_custom_reader"
	"experimental_metrics_disable_name_validation"
	"experimental_metrics_periodicreader_with_async_runtime"
	"experimental_trace_batch_span_processor_with_async_runtime"
	"internal-logs"
	"jaeger_remote_sampler"
	"logs"
	"metrics"
	"rt-tokio"
	"rt-tokio-current-thread"
	"spec_unstable_metrics_views"
	"testing"
	"trace"
)
