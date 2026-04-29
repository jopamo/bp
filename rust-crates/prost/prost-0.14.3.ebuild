# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="prost"
CRATE_VERSION="0.14.3"
CRATE_CHECKSUM="d2ea70524a2f82d518bce41317d0fae74151505651af45faf1ffbd6fd33f0568"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Protocol Buffers implementation for the Rust Language."
HOMEPAGE="https://github.com/tokio-rs/prost"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"derive"
	"no-recursion-limit"
	"std"
)
