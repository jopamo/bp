# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zmij"
CRATE_VERSION="1.0.23"
CRATE_CHECKSUM="29666d0abbfad1e3dc4dcf6144730dd3a3ab225bbbdac83319345b1b44ccfc1b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A double-to-string conversion algorithm based on Schubfach and xjb"
HOMEPAGE="https://github.com/dtolnay/zmij"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
