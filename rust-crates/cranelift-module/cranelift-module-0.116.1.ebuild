# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cranelift-module"
CRATE_VERSION="0.116.1"
CRATE_CHECKSUM="4d55612bebcf16ff7306c8a6f5bdb6d45662b8aa1ee058ecce8807ad87db719b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Support for linking functions and data with Cranelift"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime"
LICENSE="Apache-2.0-with-LLVM-exception"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"core"
	"default"
	"enable-serde"
	"std"
)
