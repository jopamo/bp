# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="async-broadcast"
CRATE_VERSION="0.7.2"
CRATE_CHECKSUM="435a87a52755b8f27fcf321ac4f04b2802e337c8c4872923137471ec39c37532"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Async broadcast channels"
HOMEPAGE="https://github.com/smol-rs/async-broadcast"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
