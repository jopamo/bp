# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="codspeed"
CRATE_VERSION="5.0.1"
CRATE_CHECKSUM="7083f253260bcb4aaa3b4aa4c52973703dabc1a85c2f193997e2689aafa8a919"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Core instrumentation library for CodSpeed"
HOMEPAGE="https://codspeed.io"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
