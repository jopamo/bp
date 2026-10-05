# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="hashlink"
CRATE_VERSION="0.12.0"
CRATE_CHECKSUM="a5081f264ed7adee96ea4b4778b6bb9da0a7228b084587aa3bd3ff05da7c5a3b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="HashMap-like containers that hold their key-value pairs in a user controllable order"
HOMEPAGE="https://github.com/djc/hashlink"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"serde_impl"
)
