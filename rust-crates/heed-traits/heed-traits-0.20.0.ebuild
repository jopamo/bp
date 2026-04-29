# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="heed-traits"
CRATE_VERSION="0.20.0"
CRATE_CHECKSUM="eb3130048d404c57ce5a1ac61a903696e8fcde7e8c2991e9fcfc1f27c3ef74ff"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The traits used inside of the fully typed LMDB wrapper, heed"
HOMEPAGE="https://github.com/Kerollmops/heed"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
