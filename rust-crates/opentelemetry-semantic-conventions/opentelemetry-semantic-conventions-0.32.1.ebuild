# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="opentelemetry-semantic-conventions"
CRATE_VERSION="0.32.1"
CRATE_CHECKSUM="c913ac17a6c451661ee255f4625d143e51647ae78ebd969b75e41c4442f4fe47"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Semantic conventions for OpenTelemetry"
HOMEPAGE="https://github.com/open-telemetry/opentelemetry-rust/tree/main/opentelemetry-semantic-conventions"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"semconv_experimental"
)
