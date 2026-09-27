# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rustversion"
CRATE_VERSION="1.0.23"
CRATE_CHECKSUM="cf54715a573b99ac80df0bc206da022bcd442c974952c7b9720069370852e21f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Conditional compilation according to rustc compiler version"
HOMEPAGE="https://github.com/dtolnay/rustversion"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
