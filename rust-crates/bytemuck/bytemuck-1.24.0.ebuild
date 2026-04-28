# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bytemuck"
CRATE_VERSION="1.24.0"
CRATE_CHECKSUM="1fbdf580320f38b612e485521afda1ee26d10cc9884efaaa750d383e13e3c5f4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A crate for mucking around with piles of bytes."
HOMEPAGE="https://github.com/Lokathor/bytemuck"
LICENSE="|| ( Zlib Apache-2.0 MIT )"
SLOT="0/${PV}"
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
