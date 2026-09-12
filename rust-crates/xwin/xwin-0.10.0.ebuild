# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="xwin"
CRATE_VERSION="0.10.0"
CRATE_CHECKSUM="e3ae2ef8d627ac8d97b3aeb67e4b711520154edca5cc80fbec551415c7b671ef"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Allows downloading and repacking the MSVC CRT and Windows SDK for cross compilation"
HOMEPAGE="https://github.com/Jake-Shadle/xwin"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
