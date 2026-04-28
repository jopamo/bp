# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasi"
CRATE_VERSION="0.11.0+wasi-snapshot-preview1"
CRATE_CHECKSUM="9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Experimental WASI API bindings for Rust"
HOMEPAGE="https://github.com/bytecodealliance/wasi"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"rustc-dep-of-std"
	"std"
)
