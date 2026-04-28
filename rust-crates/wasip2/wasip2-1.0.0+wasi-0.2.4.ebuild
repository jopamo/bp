# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasip2"
CRATE_VERSION="1.0.0+wasi-0.2.4"
CRATE_CHECKSUM="03fa2761397e5bd52002cd7e73110c71af2109aca4e521a9f40473fe685b0a24"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="WASIp2 API bindings for Rust"
HOMEPAGE="https://github.com/bytecodealliance/wasi-rs"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"bitflags"
	"default"
	"rustc-dep-of-std"
	"std"
)
