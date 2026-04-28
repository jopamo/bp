# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-metadata"
CRATE_VERSION="0.244.0"
CRATE_CHECKSUM="bb0e353e6a2fbdc176932bbaab493762eb1255a7900fe0fea1a2f96c296cc909"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Read and manipulate WebAssembly metadata"
HOMEPAGE="https://github.com/bytecodealliance/wasm-tools/tree/main/crates/wasm-metadata"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"oci"
	"serde"
)
