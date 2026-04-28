# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="opentelemetry-http"
CRATE_VERSION="0.27.0"
CRATE_CHECKSUM="10a8a7f5f6ba7c1b286c2fbca0454eaba116f63bbe69ed250b642d36fbb04d80"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Helper implementations for sending HTTP requests. Uses include propagating and extracting context over http, exporting telemetry, requesting sampling strategies."
HOMEPAGE="https://github.com/open-telemetry/opentelemetry-rust"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"hyper"
	"reqwest-rustls"
	"reqwest-rustls-webpki-roots"
)
