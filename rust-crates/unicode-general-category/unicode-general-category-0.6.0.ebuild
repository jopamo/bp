# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="unicode-general-category"
CRATE_VERSION="0.6.0"
CRATE_CHECKSUM="2281c8c1d221438e373249e065ca4989c4c36952c211ff21a0ee91c44a3869e7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast lookup of the Unicode General Category property for char"
HOMEPAGE="https://github.com/yeslogic/unicode-general-category"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
