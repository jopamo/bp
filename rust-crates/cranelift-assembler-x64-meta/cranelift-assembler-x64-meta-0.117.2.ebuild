# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cranelift-assembler-x64-meta"
CRATE_VERSION="0.117.2"
CRATE_CHECKSUM="c7496a6e92b5cee48c5d772b0443df58816dee30fed6ba19b2a28e78037ecedf"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generate a Cranelift-specific assembler for x64 instructions"
HOMEPAGE="https://crates.io/crates/cranelift-assembler-x64-meta"
LICENSE="Apache-2.0-with-LLVM-exception"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
