# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cranelift-codegen"
CRATE_VERSION="0.116.1"
CRATE_CHECKSUM="2c22032c4cb42558371cf516bb47f26cdad1819d3475c133e93c49f50ebf304e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Low-level code generator library"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime"
LICENSE="Apache-2.0-with-LLVM-exception"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"all-arch"
	"all-native-arch"
	"arm64"
	"core"
	"default"
	"disas"
	"enable-serde"
	"host-arch"
	"incremental-cache"
	"isle-errors"
	"pulley"
	"riscv64"
	"s390x"
	"souper-harvest"
	"std"
	"timing"
	"trace-log"
	"unwind"
	"x86"
)
