# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="opentelemetry-semantic-conventions"
CRATE_VERSION="0.27.0"
CRATE_CHECKSUM="bc1b6902ff63b32ef6c489e8048c5e253e2e4a803ea3ea7e783914536eb15c52"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Semantic conventions for OpenTelemetry"
HOMEPAGE="https://github.com/open-telemetry/opentelemetry-rust/tree/main/opentelemetry-semantic-conventions"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"semconv_experimental"
)
