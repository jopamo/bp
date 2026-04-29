# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="countio"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="b9702aee5d1d744c01d82f6915644f950f898e014903385464c773b96fefdecb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Byte counting for std::io::{Read, Write, Seek} and its async variants from futures and tokio."
HOMEPAGE="https://github.com/spire-rs/countio"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"full"
	"futures"
	"std"
	"tokio"
)
