# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="xwin"
CRATE_VERSION="0.9.0"
CRATE_CHECKSUM="c337699251ad0c38cf87ee63944de38c2201d017cfbb768e5a3897ae835aacc7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Allows downloading and repacking the MSVC CRT and Windows SDK for cross compilation"
HOMEPAGE="https://github.com/Jake-Shadle/xwin"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
