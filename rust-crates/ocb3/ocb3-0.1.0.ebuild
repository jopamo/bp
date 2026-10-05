# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ocb3"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="c196e0276c471c843dd5777e7543a36a298a4be942a2a688d8111cd43390dedb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of the Offset Codebook Mode v3 (OCB3) Authenticated Encryption with Associated Data (AEAD) Cipher as described in RFC7253"
HOMEPAGE="https://github.com/RustCrypto/AEADs"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"arrayvec"
	"default"
	"getrandom"
	"heapless"
	"rand_core"
	"std"
	"stream"
)
