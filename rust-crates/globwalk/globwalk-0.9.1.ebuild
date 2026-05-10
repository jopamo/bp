# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="globwalk"
CRATE_VERSION="0.9.1"
CRATE_CHECKSUM="0bf760ebf69878d9fd8f110c89703d90ce35095324d1f1edcb595c63945ee757"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Glob-matched recursive file system walking."
HOMEPAGE="https://github.com/gilnaa/globwalk"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
