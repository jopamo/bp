# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rsqlite-vfs"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="c51c9ae4df8a7fba42103df5c621fa3c37eccf3a3c650879e90fc48b11cc192c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Helping to implement SQLite VFS."
HOMEPAGE="https://crates.io/crates/rsqlite-vfs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
