# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="wasi"
CRATE_VERSION="0.14.2+wasi-0.2.4"
CRATE_CHECKSUM="9683f9a5a998d873c0d21fcbe3c083009670149a8fab228644b8bd36b2c48cb3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="WASI API bindings for Rust"
HOMEPAGE="https://github.com/bytecodealliance/wasi-rs"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"rustc-dep-of-std"
	"std"
)
