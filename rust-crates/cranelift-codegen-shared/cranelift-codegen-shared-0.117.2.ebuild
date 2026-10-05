# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cranelift-codegen-shared"
CRATE_VERSION="0.117.2"
CRATE_CHECKSUM="0f4ff8d2e1235f2d6e7fc3c6738be6954ba972cd295f09079ebffeca2f864e22"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="For code shared between cranelift-codegen-meta and cranelift-codegen"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime"
LICENSE="Apache-2.0-with-LLVM-exception"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
