# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="keccak"
CRATE_VERSION="0.1.5"
CRATE_CHECKSUM="ecc2af9a1119c51f12a14607e783cb977bde58bc069ff0c3da1095e635d70654"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of the Keccak sponge function including the keccak-f and keccak-p variants"
HOMEPAGE="https://github.com/RustCrypto/sponges/tree/master/keccak"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"asm"
	"no_unroll"
	"simd"
)
