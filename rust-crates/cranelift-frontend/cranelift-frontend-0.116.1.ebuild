# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cranelift-frontend"
CRATE_VERSION="0.116.1"
CRATE_CHECKSUM="4fac41e16729107393174b0c9e3730fb072866100e1e64e80a1a963b2e484d57"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cranelift IR builder helper"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime"
LICENSE="Apache-2.0-with-LLVM-exception"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"core"
	"default"
	"std"
)
