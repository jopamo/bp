# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasip2"
CRATE_VERSION="1.0.1+wasi-0.2.4"
CRATE_CHECKSUM="0562428422c63773dad2c345a1882263bbf4d65cf3f42e90921f787ef5ad58e7"
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
