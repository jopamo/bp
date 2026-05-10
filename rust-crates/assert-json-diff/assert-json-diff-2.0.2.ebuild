# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="assert-json-diff"
CRATE_VERSION="2.0.2"
CRATE_CHECKSUM="47e4f2b81832e72834d7518d8487a0396a28cc408186a2e8854c0f98011faf12"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Easily compare two JSON values and get great output"
HOMEPAGE="https://github.com/davidpdrsn/assert-json-diff"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
