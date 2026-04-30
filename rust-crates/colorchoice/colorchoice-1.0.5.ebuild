# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="colorchoice"
CRATE_VERSION="1.0.5"
CRATE_CHECKSUM="1d07550c9036bf2ae0c684c4297d503f838287c83c53686d05370d0e139ae570"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Global override of color control"
HOMEPAGE="https://github.com/rust-cli/anstyle.git"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
