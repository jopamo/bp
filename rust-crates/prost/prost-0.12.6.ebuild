# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="prost"
CRATE_VERSION="0.12.6"
CRATE_CHECKSUM="deb1435c188b76130da55f17a466d252ff7b1418b2ad3e037d127b94e3411f29"
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
	"prost-derive"
	"std"
)
