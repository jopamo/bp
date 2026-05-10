# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="procfs"
CRATE_VERSION="0.18.0"
CRATE_CHECKSUM="25485360a54d6861439d60facef26de713b1e126bf015ec8f98239467a2b82f7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Interface to the linux procfs pseudo-filesystem"
HOMEPAGE="https://github.com/eminence/procfs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"backtrace"
	"default"
	"serde1"
)
