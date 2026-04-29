# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="matrixmultiply"
CRATE_VERSION="0.3.10"
CRATE_CHECKSUM="a06de3016e9fae57a36fd14dba131fccf49f74b40b7fbdb472f96e361ec71a08"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="General matrix multiplication for f32 and f64 matrices. Operates on matrices with general layout (they can use arbitrary row and column stride). Detects and uses AVX or SSE2 on x86 platforms transparently for higher performance. Uses a microkernel strategy, so that the implementation is easy to parallelize and optimize. Supports multithreading."
HOMEPAGE="https://github.com/bluss/matrixmultiply/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cgemm"
	"constconf"
	"default"
	"std"
	"threading"
)
