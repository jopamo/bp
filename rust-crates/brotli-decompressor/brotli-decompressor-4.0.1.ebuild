# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="brotli-decompressor"
CRATE_VERSION="4.0.1"
CRATE_CHECKSUM="9a45bd2e4095a8b518033b128020dd4a55aab1c0a381ba4404a472630f4bc362"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A brotli decompressor that with an interface avoiding the rust stdlib. This makes it suitable for embedded devices and kernels. It is designed with a pluggable allocator so that the standard lib's allocator may be employed. The default build also includes a stdlib allocator and stream interface. Disable this with --features=no-stdlib. Alternatively, --features=unsafe turns off array bounds checks and memory initialization but provides a safe interface for the caller. Without adding the --features=unsafe argument, all included code is safe. For compression in addition to this library, download https://github.com/dropbox/rust-brotli"
HOMEPAGE="https://github.com/dropbox/rust-brotli-decompressor"
LICENSE="|| ( BSD-3-Clause MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"benchmark"
	"default"
	"disable-timer"
	"ffi-api"
	"pass-through-ffi-panics"
	"seccomp"
	"std"
	"unsafe"
)
