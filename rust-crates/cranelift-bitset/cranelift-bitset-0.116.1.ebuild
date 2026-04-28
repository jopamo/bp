# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cranelift-bitset"
CRATE_VERSION="0.116.1"
CRATE_CHECKSUM="7c6e3969a7ce267259ce244b7867c5d3bc9e65b0a87e81039588dfdeaede9f34"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Various bitset stuff for use inside Cranelift"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime"
LICENSE="Apache-2.0-with-LLVM-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"arbitrary"
	"enable-serde"
)
