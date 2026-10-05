# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="color_quant"
CRATE_VERSION="1.1.0"
CRATE_CHECKSUM="3d7b894f5411737b7867f4827955924d7c254fc9f4d91a6aad6b097804b1018b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Color quantization library to reduce n colors to 256 colors."
HOMEPAGE="https://github.com/image-rs/color_quant.git"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
