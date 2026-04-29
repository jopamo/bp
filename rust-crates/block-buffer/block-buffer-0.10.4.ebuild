# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="block-buffer"
CRATE_VERSION="0.10.4"
CRATE_CHECKSUM="3078c7629b62d3f0439517fa394996acacc5cbc91c5a20d8c658e77abd503a71"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Buffer type for block processing of data"
HOMEPAGE="https://github.com/RustCrypto/utils"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
