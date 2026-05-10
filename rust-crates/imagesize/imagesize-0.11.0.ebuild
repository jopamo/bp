# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="imagesize"
CRATE_VERSION="0.11.0"
CRATE_CHECKSUM="b72ad49b554c1728b1e83254a1b1565aea4161e28dabbfa171fc15fe62299caf"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Quick probing of image dimensions without loading the entire file."
HOMEPAGE="https://github.com/Roughsketch/imagesize"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
