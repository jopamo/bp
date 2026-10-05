# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cranelift-isle"
CRATE_VERSION="0.117.2"
CRATE_CHECKSUM="f900e0a3847d51eed0321f0777947fb852ccfce0da7fb070100357f69a2f37fc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="ISLE: Instruction Selection and Lowering Expressions. A domain-specific language for instruction selection in Cranelift."
HOMEPAGE="https://github.com/bytecodealliance/wasmtime/tree/main/cranelift/isle"
LICENSE="Apache-2.0-with-LLVM-exception"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"fancy-errors"
	"logging"
)
