# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="console-subscriber"
CRATE_VERSION="0.5.0"
CRATE_CHECKSUM="fb4915b7d8dd960457a1b6c380114c2944f728e7c65294ab247ae6b6f1f37592"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A \`tracing-subscriber::Layer\` for collecting Tokio console telemetry."
HOMEPAGE="https://github.com/tokio-rs/console/blob/main/console-subscriber"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"env-filter"
	"grpc-web"
	"parking_lot"
	"vsock"
)
