# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="blake3"
CRATE_VERSION="1.8.3"
CRATE_CHECKSUM="2468ef7d57b3fb7e16b576e8377cdbde2320c60e1491e961d11da40fc4f02a2d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="the BLAKE3 hash function"
HOMEPAGE="https://github.com/BLAKE3-team/BLAKE3"
LICENSE="|| ( CC0-1.0 Apache-2.0 Apache-2.0-with-LLVM-exception )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"digest"
	"mmap"
	"neon"
	"no_avx2"
	"no_avx512"
	"no_neon"
	"no_sse2"
	"no_sse41"
	"prefer_intrinsics"
	"pure"
	"rayon"
	"std"
	"traits-preview"
	"wasm32_simd"
	"zeroize"
)
