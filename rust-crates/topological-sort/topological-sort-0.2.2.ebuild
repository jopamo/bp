# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="topological-sort"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="ea68304e134ecd095ac6c3574494fc62b909f416c4fca77e440530221e549d3d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Performs topological sorting."
HOMEPAGE="https://github.com/gifnksm/topological-sort-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
