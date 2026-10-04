# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="kqueue"
CRATE_VERSION="1.2.1"
CRATE_CHECKSUM="8d763e5b24120b4ddf50de6c92308156765aabfbbccebf401da7cff2d70a41ea"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="kqueue interface for BSDs"
HOMEPAGE="https://gitlab.com/rust-kqueue/rust-kqueue"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
