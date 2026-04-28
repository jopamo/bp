# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustc_apfloat"
CRATE_VERSION="0.2.3+llvm-462a31f5a5ab"
CRATE_CHECKSUM="486c2179b4796f65bfe2ee33679acf0927ac83ecf583ad6c91c3b4570911b9ad"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust port of C++ llvm::APFloat library"
HOMEPAGE="https://github.com/rust-lang/rustc_apfloat"
LICENSE="Apache-2.0-with-LLVM-exception"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
