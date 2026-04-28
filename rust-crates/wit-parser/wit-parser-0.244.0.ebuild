# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wit-parser"
CRATE_VERSION="0.244.0"
CRATE_CHECKSUM="ecc8ac4bc1dc3381b7f59c34f00b67e18f910c2c0f50015669dde7def656a736"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Tooling for parsing `*.wit` files and working with their contents."
HOMEPAGE="https://github.com/bytecodealliance/wasm-tools/tree/main/crates/wit-parser"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"decoding"
	"default"
	"serde"
	"wat"
)
