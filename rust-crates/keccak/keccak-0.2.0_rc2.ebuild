# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="keccak"
CRATE_VERSION="0.2.0-rc.2"
CRATE_CHECKSUM="882b69cb15b1f78b51342322a97ccd16f5123d1dc8a3da981a95244f488e8692"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of the Keccak sponge function including the keccak-f and keccak-p variants"
HOMEPAGE="https://github.com/RustCrypto/sponges/tree/master/keccak"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
