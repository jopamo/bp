# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="sha2"
CRATE_VERSION="0.10.8"
CRATE_CHECKSUM="793db75ad2bcafc3ffa7c68b215fee268f537982cd901d132f89c6343f3a3dc8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of the SHA-2 hash function family including SHA-224, SHA-256, SHA-384, and SHA-512."
HOMEPAGE="https://github.com/RustCrypto/hashes"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"asm"
	"asm-aarch64"
	"compress"
	"default"
	"force-soft"
	"loongarch64_asm"
	"oid"
	"std"
)
