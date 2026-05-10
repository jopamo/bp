# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tagu"
CRATE_VERSION="0.1.6"
CRATE_CHECKSUM="eddb6b06d20fba9ed21fca3d696ee1b6e870bca0bcf9fa2971f6ae2436de576a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Write SVG / HTML / XML programmatically"
HOMEPAGE="https://github.com/tiby312/tagu"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
