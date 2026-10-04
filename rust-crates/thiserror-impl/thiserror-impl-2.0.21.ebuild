# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="thiserror-impl"
CRATE_VERSION="2.0.21"
CRATE_CHECKSUM="fe5197923287db20a58125f0bc85c062f7f2c892de97b18c356f9efb14b28524"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation detail of the \`thiserror\` crate"
HOMEPAGE="https://github.com/dtolnay/thiserror"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
