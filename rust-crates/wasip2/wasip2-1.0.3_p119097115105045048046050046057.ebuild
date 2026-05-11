# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="wasip2"
CRATE_VERSION="1.0.3+wasi-0.2.9"
CRATE_CHECKSUM="20064672db26d7cdc89c7798c48a0fdfac8213434a1186e5ef29fd560ae223d6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="WASIp2 API bindings for Rust"
HOMEPAGE="https://github.com/bytecodealliance/wasi-rs"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bitflags"
	"default"
	"rustc-dep-of-std"
	"std"
)
