# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasi"
CRATE_VERSION="0.14.5+wasi-0.2.4"
CRATE_CHECKSUM="a4494f6290a82f5fe584817a676a34b9d6763e8d9d18204009fb31dceca98fd4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="WASI API bindings for Rust"
HOMEPAGE="https://github.com/bytecodealliance/wasi-rs"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"bitflags"
	"default"
	"std"
)
