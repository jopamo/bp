# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cranelift-codegen-shared"
CRATE_VERSION="0.116.1"
CRATE_CHECKSUM="40180f5497572f644ce88c255480981ae2ec1d7bb4d8e0c0136a13b87a2f2ceb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="For code shared between cranelift-codegen-meta and cranelift-codegen"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime"
LICENSE="Apache-2.0-with-LLVM-exception"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
