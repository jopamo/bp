# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="hash2curve"
CRATE_VERSION="0.14.0-rc.10"
CRATE_CHECKSUM="3448b4c05089875da77b94b1177c36f79a5dcf4b316bc999f8dd3d7f3da42eda"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="hash2curve algorithm implementation"
HOMEPAGE="https://github.com/RustCrypto/elliptic-curves/tree/master/hash2curve"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
