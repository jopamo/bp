# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="unicode-ccc"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="ce61d488bcdc9bc8b5d1772c404828b17fc481c0a582b5581e95fb233aef503e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Unicode Canonical Combining Class detection"
HOMEPAGE="https://github.com/RazrFalcon/unicode-ccc"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
