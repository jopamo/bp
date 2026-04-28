# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasi"
CRATE_VERSION="0.11.1+wasi-snapshot-preview1"
CRATE_CHECKSUM="ccf3ec651a847eb01de73ccad15eb7d99f80485de043efb2f370cd654f4ea44b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Experimental WASI API bindings for Rust"
HOMEPAGE="https://github.com/bytecodealliance/wasi"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"rustc-dep-of-std"
	"std"
)
