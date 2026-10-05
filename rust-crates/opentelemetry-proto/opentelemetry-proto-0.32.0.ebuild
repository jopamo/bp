# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="opentelemetry-proto"
CRATE_VERSION="0.32.0"
CRATE_CHECKSUM="56d658ba1faf63f7b9c492cfbe6e0ec365440a16132d3270c1065f7b33f1b638"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Protobuf generated files and transformations."
HOMEPAGE="https://github.com/open-telemetry/opentelemetry-rust/tree/main/opentelemetry-proto"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"full"
	"gen-tonic"
	"gen-tonic-messages"
	"internal-logs"
	"logs"
	"metrics"
	"profiles"
	"testing"
	"trace"
	"with-schemars"
	"with-serde"
	"zpages"
)
