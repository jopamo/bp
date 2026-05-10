# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="aes"
CRATE_VERSION="0.8.4"
CRATE_CHECKSUM="b169f7a6d4742236a0a00c541b845991d0ac43e546831af1249753ab4c3aa3a0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of the Advanced Encryption Standard (a.k.a. Rijndael)"
HOMEPAGE="https://github.com/RustCrypto/block-ciphers"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"hazmat"
)
