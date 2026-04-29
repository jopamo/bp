# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="zerovec"
CRATE_VERSION="0.11.5"
CRATE_CHECKSUM="6c28719294829477f525be0186d13efa9a3c602f7ec202ca9e353d310fb9a002"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Zero-copy vector backed by a byte array"
HOMEPAGE="https://github.com/unicode-org/icu4x"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"databake"
	"derive"
	"hashmap"
	"serde"
	"std"
	"yoke"
)
