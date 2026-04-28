# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cranelift"
CRATE_VERSION="0.116.1"
CRATE_CHECKSUM="a71de5e59f616d79d14d2c71aa2799ce898241d7f10f7e64a4997014b4000a28"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Umbrella for commonly-used cranelift crates"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime"
LICENSE="Apache-2.0-with-LLVM-exception"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"core"
	"default"
	"frontend"
	"interpreter"
	"jit"
	"module"
	"native"
	"object"
	"std"
)
