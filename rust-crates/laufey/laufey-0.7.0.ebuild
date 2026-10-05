# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="laufey"
CRATE_VERSION="0.7.0"
CRATE_CHECKSUM="8a2a04490eb866f17dcbbb44c8277b45964eeb0f68bb17c444e69c2feff0db94"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A web embedded framework: build cross-platform apps with web technologies and your choice of browser engine."
HOMEPAGE="https://github.com/littledivy/laufey"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
