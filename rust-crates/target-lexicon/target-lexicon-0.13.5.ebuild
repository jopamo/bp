# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="target-lexicon"
CRATE_VERSION="0.13.5"
CRATE_CHECKSUM="adb6935a6f5c20170eeceb1a3835a49e12e19d792f6dd344ccc76a985ca5a6ca"
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
