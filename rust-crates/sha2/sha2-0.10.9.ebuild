# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="sha2"
CRATE_VERSION="0.10.9"
CRATE_CHECKSUM="a7507d819769d01a365ab707794a4084392c824f54a7a6a7862f8c3d0892b283"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of the SHA-2 hash function family including SHA-224, SHA-256, SHA-384, and SHA-512."
HOMEPAGE="https://github.com/RustCrypto/hashes"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"asm"
	"asm-aarch64"
	"compress"
	"default"
	"force-soft"
	"force-soft-compact"
	"loongarch64_asm"
	"oid"
	"std"
)
