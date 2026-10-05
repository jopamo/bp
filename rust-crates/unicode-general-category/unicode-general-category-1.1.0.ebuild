# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="unicode-general-category"
CRATE_VERSION="1.1.0"
CRATE_CHECKSUM="0b993bddc193ae5bd0d623b49ec06ac3e9312875fdae725a975c51db1cc1677f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast lookup of the Unicode General Category property for char"
HOMEPAGE="https://github.com/yeslogic/unicode-general-category"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
