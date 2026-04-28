# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-encoder"
CRATE_VERSION="0.244.0"
CRATE_CHECKSUM="990065f2fe63003fe337b932cfb5e3b80e0b4d0f5ff650e6985b1048f62c8319"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A low-level WebAssembly encoder."
HOMEPAGE="https://github.com/bytecodealliance/wasm-tools/tree/main/crates/wasm-encoder"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"component-model"
	"default"
	"std"
)
