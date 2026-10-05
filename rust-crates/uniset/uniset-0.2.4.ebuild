# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="uniset"
CRATE_VERSION="0.2.4"
CRATE_CHECKSUM="40789245bbff5f31eb773c9ac4ee5c4e15eab9640d975e124d6ce4c34a6410d7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A hierarchical, growable bit set with support for in-place atomic operations."
HOMEPAGE="https://github.com/udoprog/uniset"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"vec-safety"
)
