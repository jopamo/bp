# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="brotli"
CRATE_VERSION="6.0.0"
CRATE_CHECKSUM="74f7971dbd9326d58187408ab83117d8ac1bb9c17b085fdacd1cf2f598719b6b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A brotli compressor and decompressor that with an interface avoiding the rust stdlib. This makes it suitable for embedded devices and kernels. It is designed with a pluggable allocator so that the standard lib's allocator may be employed. The default build also includes a stdlib allocator and stream interface. Disable this with --features=no-stdlib. All included code is safe."
HOMEPAGE="https://github.com/dropbox/rust-brotli"
LICENSE="|| ( BSD-3-Clause MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"benchmark"
	"default"
	"disable-timer"
	"external-literal-probability"
	"ffi-api"
	"pass-through-ffi-panics"
	"seccomp"
	"simd"
	"std"
	"validation"
	"vector_scratch_space"
)
