# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bytemuck"
CRATE_VERSION="1.21.0"
CRATE_CHECKSUM="ef657dfab802224e671f5818e9a4935f9b1957ed18e58292690cc39e7a4092a3"
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
	"latest_stable_rust"
	"min_const_generics"
	"must_cast"
	"must_cast_extra"
	"nightly_docs"
	"nightly_float"
	"nightly_portable_simd"
	"nightly_stdsimd"
	"track_caller"
	"transparentwrapper_extra"
	"unsound_ptr_pod_impl"
	"wasm_simd"
	"zeroable_atomics"
	"zeroable_maybe_uninit"
)
