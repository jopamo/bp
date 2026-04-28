# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cranelift-entity"
CRATE_VERSION="0.116.1"
CRATE_CHECKSUM="4b2d0d9618275474fbf679dd018ac6e009acbd6ae6850f6a67be33fb3b00b323"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Data structures using entity references as mapping keys"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime"
LICENSE="Apache-2.0-with-LLVM-exception"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"enable-serde"
)
