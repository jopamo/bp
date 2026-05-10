# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="munge"
CRATE_VERSION="0.4.7"
CRATE_CHECKSUM="5e17401f259eba956ca16491461b6e8f72913a0a114e39736ce404410f915a0c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macro for custom destructuring"
HOMEPAGE="https://github.com/djkoloski/munge"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
