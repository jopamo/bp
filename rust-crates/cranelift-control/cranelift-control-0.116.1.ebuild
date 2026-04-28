# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cranelift-control"
CRATE_VERSION="0.116.1"
CRATE_CHECKSUM="26d132c6d0bd8a489563472afc171759da0707804a65ece7ceb15a8c6d7dd5ef"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="White-box fuzz testing framework"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime"
LICENSE="Apache-2.0-with-LLVM-exception"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"chaos"
	"default"
	"fuzz"
)
