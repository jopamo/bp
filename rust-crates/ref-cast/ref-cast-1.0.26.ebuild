# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ref-cast"
CRATE_VERSION="1.0.26"
CRATE_CHECKSUM="216e8f773d7923bcba9ceb86a86c93cabb3903a11872fc3f138c49630e50b96d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Safely cast &T to &U where the struct U contains a single field of type T."
HOMEPAGE="https://github.com/dtolnay/ref-cast"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
