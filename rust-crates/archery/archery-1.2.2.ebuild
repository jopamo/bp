# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="archery"
CRATE_VERSION="1.2.2"
CRATE_CHECKSUM="70e0a5f99dfebb87bb342d0f53bb92c81842e100bbb915223e38349580e5441d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Abstract over the atomicity of reference-counting pointers"
HOMEPAGE="https://github.com/orium/archery"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"fatal-warnings"
	"serde"
	"triomphe"
)
