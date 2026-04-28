# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasi"
CRATE_VERSION="0.14.7+wasi-0.2.4"
CRATE_CHECKSUM="883478de20367e224c0090af9cf5f9fa85bed63a95c1abf3afc5c083ebc06e8c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="WASI API bindings for Rust"
HOMEPAGE="https://github.com/bytecodealliance/wasi-rs"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bitflags"
	"default"
	"std"
)
