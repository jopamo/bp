# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="chacha20"
CRATE_VERSION="0.10.0"
CRATE_CHECKSUM="6f8d983286843e49675a4b7a2d174efe136dc93a18d69130dd18198a6c167601"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The ChaCha20 stream cipher (RFC 8439) implemented in pure Rust using traits from the RustCrypto \`cipher\` crate, with optional architecture-specific hardware acceleration (AVX2, SSE2). Additionally provides the ChaCha8, ChaCha12, XChaCha20, XChaCha12 and XChaCha8 stream ciphers, and also optional rand_core-compatible RNGs based on those ciphers."
HOMEPAGE="https://github.com/RustCrypto/stream-ciphers"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"legacy"
	"rng"
	"xchacha"
)
