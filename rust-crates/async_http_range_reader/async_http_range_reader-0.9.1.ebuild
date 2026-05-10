# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="async_http_range_reader"
CRATE_VERSION="0.9.1"
CRATE_CHECKSUM="2b537c00269e3f943e06f5d7cabf8ccd281b800fd0c7f111dd82f77154334197"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library for streaming reading of files over HTTP using range requests"
HOMEPAGE="https://github.com/prefix-dev/async_http_range_reader"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
