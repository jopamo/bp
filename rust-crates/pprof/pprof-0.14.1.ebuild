# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="pprof"
CRATE_VERSION="0.14.1"
CRATE_CHECKSUM="afad4d4df7b31280028245f152d5a575083e2abb822d05736f5e47653e77689f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An internal perf tools for rust programs."
HOMEPAGE="https://github.com/tikv/pprof-rs"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"_protobuf"
	"cpp"
	"default"
	"flamegraph"
	"frame-pointer"
	"prost-codec"
	"protobuf-codec"
)
