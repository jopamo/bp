# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="opentelemetry-proto"
CRATE_VERSION="0.27.0"
CRATE_CHECKSUM="a6e05acbfada5ec79023c85368af14abd0b307c015e9064d249b2a950ef459a6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Protobuf generated files and transformations."
HOMEPAGE="https://github.com/open-telemetry/opentelemetry-rust/tree/main/opentelemetry-proto"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"full"
	"gen-tonic"
	"gen-tonic-messages"
	"logs"
	"metrics"
	"populate-logs-event-name"
	"testing"
	"trace"
	"with-schemars"
	"with-serde"
	"zpages"
)
