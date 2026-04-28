# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cranelift-isle"
CRATE_VERSION="0.116.1"
CRATE_CHECKSUM="1ca20d576e5070044d0a72a9effc2deacf4d6aa650403189d8ea50126483944d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="ISLE: Instruction Selection and Lowering Expressions. A domain-specific language for instruction selection in Cranelift."
HOMEPAGE="https://github.com/bytecodealliance/wasmtime/tree/main/cranelift/isle"
LICENSE="Apache-2.0-with-LLVM-exception"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"fancy-errors"
	"logging"
)
