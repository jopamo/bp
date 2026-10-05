# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="inventory"
CRATE_VERSION="0.3.21"
CRATE_CHECKSUM="bc61209c082fbeb19919bee74b176221b27223e27b65d781eb91af24eb1fb46e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Typed distributed plugin registration"
HOMEPAGE="https://github.com/dtolnay/inventory"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
