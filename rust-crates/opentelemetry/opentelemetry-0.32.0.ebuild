# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="opentelemetry"
CRATE_VERSION="0.32.0"
CRATE_CHECKSUM="b0142c63252a9e054e68a4c61a5778f7b14f576274d593f8ce883d191a099682"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="OpenTelemetry API for Rust"
HOMEPAGE="https://github.com/open-telemetry/opentelemetry-rust/tree/main/opentelemetry"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"experimental_metrics_bound_instruments"
	"futures"
	"internal-logs"
	"logs"
	"metrics"
	"testing"
	"trace"
)
