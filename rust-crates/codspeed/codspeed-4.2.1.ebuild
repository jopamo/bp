# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="codspeed"
CRATE_VERSION="4.2.1"
CRATE_CHECKSUM="5f0d98d97fd75ca4489a1a0997820a6521531085e7c8a98941bd0e1264d567dd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Core instrumentation library for CodSpeed"
HOMEPAGE="https://codspeed.io"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
