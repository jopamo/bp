# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cranelift-native"
CRATE_VERSION="0.116.1"
CRATE_CHECKSUM="b8dee82f3f1f2c4cba9177f1cc5e350fe98764379bcd29340caa7b01f85076c7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Support for targeting the host with Cranelift"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime"
LICENSE="Apache-2.0-with-LLVM-exception"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"core"
	"default"
	"std"
)
