# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="wasmparser"
CRATE_VERSION="0.244.0"
CRATE_CHECKSUM="47b807c72e1bac69382b3a6fb3dbe8ea4c0ed87ff5629b8685ae6b9a611028fe"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple event-driven library for parsing WebAssembly binary files."
HOMEPAGE="https://github.com/bytecodealliance/wasm-tools/tree/main/crates/wasmparser"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"component-model"
	"default"
	"features"
	"hash-collections"
	"prefer-btree-collections"
	"serde"
	"simd"
	"std"
	"validate"
)
