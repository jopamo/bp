# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="kqueue"
CRATE_VERSION="1.2.0"
CRATE_CHECKSUM="273c0752728918e0ac4976f2b275b6fefb9ecd400585dec929419f3844cd87b5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="kqueue interface for BSDs"
HOMEPAGE="https://gitlab.com/rust-kqueue/rust-kqueue"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
