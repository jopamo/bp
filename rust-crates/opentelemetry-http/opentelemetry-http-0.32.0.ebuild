# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="opentelemetry-http"
CRATE_VERSION="0.32.0"
CRATE_CHECKSUM="5683015d09e2df236ef005b17f6f196f0d5f6313c4fa43a7b6a53b52776e4331"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Helper implementations for sending HTTP requests. Uses include propagating and extracting context over http, exporting telemetry, requesting sampling strategies."
HOMEPAGE="https://github.com/open-telemetry/opentelemetry-rust/tree/main/opentelemetry-http"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"hyper"
	"internal-logs"
	"reqwest"
	"reqwest-blocking"
	"reqwest-rustls"
	"reqwest-rustls-webpki-roots"
)
