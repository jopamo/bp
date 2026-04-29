# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="lru-slab"
CRATE_VERSION="0.1.2"
CRATE_CHECKSUM="112b39cec0b298b6c1999fee3e31427f74f676e4cb9879ed1a121b43661a4154"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pre-allocated storage with constant-time LRU tracking"
HOMEPAGE="https://github.com/Ralith/lru-slab"
LICENSE="|| ( MIT Apache-2.0 Zlib )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
