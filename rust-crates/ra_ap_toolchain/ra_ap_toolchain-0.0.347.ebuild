# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ra_ap_toolchain"
CRATE_VERSION="0.0.347"
CRATE_CHECKSUM="5f7748b05a913c21f6182b4c2d7c7009251938b8eb01a2b96e61d0c7ca4aacc2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Discovery of \`cargo\` & \`rustc\` executables for rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
