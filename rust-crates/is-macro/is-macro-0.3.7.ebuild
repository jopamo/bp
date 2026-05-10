# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="is-macro"
CRATE_VERSION="0.3.7"
CRATE_CHECKSUM="1d57a3e447e24c22647738e4607f1df1e0ec6f72e16182c4cd199f647cdfb0e4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Derive methods for using custom enums like Option / Result"
HOMEPAGE="https://github.com/dudykr/ddbase.git"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
