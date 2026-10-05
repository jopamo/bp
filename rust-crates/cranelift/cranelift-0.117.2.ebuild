# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cranelift"
CRATE_VERSION="0.117.2"
CRATE_CHECKSUM="e3f447f063d1107cb3f1677402c61d4f4b76ce7bc49ed6b8325d4bc747ca40a1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Umbrella for commonly-used cranelift crates"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime"
LICENSE="Apache-2.0-with-LLVM-exception"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"core"
	"default"
	"frontend"
	"interpreter"
	"jit"
	"module"
	"native"
	"object"
	"std"
)
