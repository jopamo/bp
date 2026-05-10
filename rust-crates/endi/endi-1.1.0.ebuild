# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="endi"
CRATE_VERSION="1.1.0"
CRATE_CHECKSUM="a3d8a32ae18130a3c84dd492d4215c3d913c3b07c6b63c2eb3eb7ff1101ab7bf"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple endian-handling library"
HOMEPAGE="https://github.com/zeenix/endi"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
