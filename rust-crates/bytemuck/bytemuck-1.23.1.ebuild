# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="bytemuck"
CRATE_VERSION="1.23.1"
CRATE_CHECKSUM="5c76a5792e44e4abe34d3abf15636779261d45a7450612059293d1d2cfc63422"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A crate for mucking around with piles of bytes."
HOMEPAGE="https://github.com/Lokathor/bytemuck"
LICENSE="|| ( Zlib Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"aarch64_simd"
	"align_offset"
	"alloc_uninit"
	"avx512_simd"
	"const_zeroed"
	"derive"
	"extern_crate_alloc"
	"extern_crate_std"
	"impl_core_error"
	"latest_stable_rust"
	"min_const_generics"
	"must_cast"
	"must_cast_extra"
	"nightly_docs"
	"nightly_float"
	"nightly_portable_simd"
	"nightly_stdsimd"
	"pod_saturating"
	"track_caller"
	"transparentwrapper_extra"
	"unsound_ptr_pod_impl"
	"wasm_simd"
	"zeroable_atomics"
	"zeroable_maybe_uninit"
	"zeroable_unwind_fn"
)
