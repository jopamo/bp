# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasip2"
CRATE_VERSION="1.0.2+wasi-0.2.9"
CRATE_CHECKSUM="9517f9239f02c069db75e65f174b3da828fe5f5b945c4dd26bd25d89c03ebcf5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="WASIp2 API bindings for Rust"
HOMEPAGE="https://github.com/bytecodealliance/wasi-rs"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bitflags"
	"default"
	"rustc-dep-of-std"
	"std"
)
