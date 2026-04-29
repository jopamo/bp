# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="prometheus"
CRATE_VERSION="0.14.0"
CRATE_CHECKSUM="3ca5326d8d0b950a9acd87e6a3f94745394f62e4dae1b1ee22b2bc0c394af43a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Prometheus instrumentation library for Rust applications."
HOMEPAGE="https://github.com/tikv/rust-prometheus"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"gen"
	"nightly"
	"process"
	"push"
)
