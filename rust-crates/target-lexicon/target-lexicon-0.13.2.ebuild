# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="target-lexicon"
CRATE_VERSION="0.13.2"
CRATE_CHECKSUM="e502f78cdbb8ba4718f566c418c52bc729126ffd16baee5baa718cf25dd5a69a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="LLVM target triple types"
HOMEPAGE="https://github.com/bytecodealliance/target-lexicon"
LICENSE="Apache-2.0-with-LLVM-exception"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"arch_zkasm"
	"default"
	"serde_support"
	"std"
)
