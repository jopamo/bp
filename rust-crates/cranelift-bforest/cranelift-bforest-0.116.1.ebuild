# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cranelift-bforest"
CRATE_VERSION="0.116.1"
CRATE_CHECKSUM="e15d04a0ce86cb36ead88ad68cf693ffd6cda47052b9e0ac114bc47fd9cd23c4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A forest of B+-trees"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime"
LICENSE="Apache-2.0-with-LLVM-exception"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
