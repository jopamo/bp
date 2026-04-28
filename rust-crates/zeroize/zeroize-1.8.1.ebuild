# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zeroize"
CRATE_VERSION="1.8.1"
CRATE_CHECKSUM="ced3678a2879b30306d323f4542626697a464a97c0a07c9aebf7ebca65cd4dde"
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
