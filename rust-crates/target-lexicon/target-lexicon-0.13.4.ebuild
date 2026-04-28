# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="target-lexicon"
CRATE_VERSION="0.13.4"
CRATE_CHECKSUM="b1dd07eb858a2067e2f3c7155d54e929265c264e6f37efe3ee7a8d1b5a1dd0ba"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="LLVM target triple types"
HOMEPAGE="https://github.com/bytecodealliance/target-lexicon"
LICENSE="Apache-2.0-with-LLVM-exception"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"arch_z80"
	"arch_zkasm"
	"default"
	"serde_support"
	"std"
)
