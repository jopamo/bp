# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="unicode-ccc"
CRATE_VERSION="0.1.2"
CRATE_CHECKSUM="cc2520efa644f8268dce4dcd3050eaa7fc044fca03961e9998ac7e2e92b77cf1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Unicode Canonical Combining Class detection"
HOMEPAGE="https://github.com/RazrFalcon/unicode-ccc"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
