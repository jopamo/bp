# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="smallbitvec"
CRATE_VERSION="2.6.1"
CRATE_CHECKSUM="9b0e903ee191d8f7a8fbf0d712c3a1699d19e04ceba5ad1eb673053c7d938a09"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A bit vector optimized for size and inline storage"
HOMEPAGE="https://github.com/servo/smallbitvec"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
