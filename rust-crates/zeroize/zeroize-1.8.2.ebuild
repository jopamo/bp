# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="zeroize"
CRATE_VERSION="1.8.2"
CRATE_CHECKSUM="b97154e67e32c85465826e8bcc1c59429aaaf107c1e4a9e53c8d8ccd5eff88d0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Securely clear secrets from memory with a simple trait built on stable Rust primitives which guarantee memory is zeroed using an operation will not be 'optimized away' by the compiler. Uses a portable pure Rust implementation that works everywhere, even WASM!"
HOMEPAGE="https://github.com/RustCrypto/utils/tree/master/zeroize"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"aarch64"
	"alloc"
	"default"
	"derive"
	"simd"
	"std"
)
