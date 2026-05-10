# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="data-url"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="8d7439c3735f405729d52c3fbbe4de140eaf938a1fe47d227c27f8254d4302a5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Processing of data: URL according to WHATWG’s Fetch Standard"
HOMEPAGE="https://github.com/servo/rust-url"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
