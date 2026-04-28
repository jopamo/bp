# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="opentelemetry"
CRATE_VERSION="0.27.0"
CRATE_CHECKSUM="0f3cebff57f7dbd1255b44d8bddc2cebeb0ea677dbaa2e25a3070a91b318f660"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="OpenTelemetry API for Rust"
HOMEPAGE="https://github.com/open-telemetry/opentelemetry-rust"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"internal-logs"
	"logs"
	"metrics"
	"otel_unstable"
	"spec_unstable_logs_enabled"
	"testing"
	"trace"
)
