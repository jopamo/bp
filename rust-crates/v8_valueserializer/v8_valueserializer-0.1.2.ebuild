# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="v8_valueserializer"
CRATE_VERSION="0.1.2"
CRATE_CHECKSUM="9e05741b8524f73cbf239bea12239458d3a835246c5c637cc9e7e601eac60770"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust implementation of V8's ValueSerializer and ValueDeserializer"
HOMEPAGE="https://github.com/denoland/v8_valueserializer"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
