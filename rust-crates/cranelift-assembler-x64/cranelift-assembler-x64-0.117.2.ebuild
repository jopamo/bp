# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cranelift-assembler-x64"
CRATE_VERSION="0.117.2"
CRATE_CHECKSUM="d2b83fcf2fc1c8954561490d02079b496fd0c757da88129981e15bfe3a548229"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Cranelift-specific x64 assembler"
HOMEPAGE="https://crates.io/crates/cranelift-assembler-x64"
LICENSE="Apache-2.0-with-LLVM-exception"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"arbitrary"
)
