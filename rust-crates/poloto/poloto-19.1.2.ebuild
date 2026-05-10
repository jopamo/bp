# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="poloto"
CRATE_VERSION="19.1.2"
CRATE_CHECKSUM="164dbd541c9832e92fa34452e9c2e98b515a548a3f8549fb2402fe1cd5e46b96"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Simple 2D plotting library that outputs SVG and can be styled using CSS"
HOMEPAGE="https://github.com/tiby312/poloto-project"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
