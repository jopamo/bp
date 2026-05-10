# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="deadpool-runtime"
CRATE_VERSION="0.1.4"
CRATE_CHECKSUM="092966b41edc516079bdf31ec78a2e0588d1d0c08f78b91d8307215928642b2b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Dead simple async pool utitities for sync managers"
HOMEPAGE="https://github.com/bikeshedder/deadpool"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
