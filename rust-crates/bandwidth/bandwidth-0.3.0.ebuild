# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="bandwidth"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="7a464cd54c99441ba44d3d09f6f980f8c29d068645022852ab66cbaad42ef6a0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library for representing bandwidth speed in a variety of units, mimicking the \`core::time::Duration\` struct."
HOMEPAGE="https://github.com/stack-rs/bandwidth"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
