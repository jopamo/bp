# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="inout"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="4250ce6452e92010fdf7268ccc5d14faa80bb12fc741938534c58f16804e03c7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Custom reference types for code generic over in-place and buffer-to-buffer modes of operation."
HOMEPAGE="https://github.com/RustCrypto/utils"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
