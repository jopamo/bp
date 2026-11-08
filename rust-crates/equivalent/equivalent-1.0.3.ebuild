# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="equivalent"
CRATE_VERSION="1.0.3"
CRATE_CHECKSUM="00d174d5400e5e8fd687ad1049e2f578285fa914201b1af7e8b112a4546bd826"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Traits for key comparison in maps."
HOMEPAGE="https://github.com/indexmap-rs/equivalent"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
