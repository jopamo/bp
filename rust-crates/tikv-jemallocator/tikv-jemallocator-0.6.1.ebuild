# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tikv-jemallocator"
CRATE_VERSION="0.6.1"
CRATE_CHECKSUM="0359b4327f954e0567e69fb191cf1436617748813819c94b8cd4a431422d053a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust allocator backed by jemalloc"
HOMEPAGE="https://github.com/tikv/jemallocator"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc_trait"
	"background_threads"
	"background_threads_runtime_support"
	"debug"
	"default"
	"disable_cache_oblivious"
	"disable_initial_exec_tls"
	"override_allocator_on_supported_platforms"
	"profiling"
	"stats"
	"unprefixed_malloc_on_supported_platforms"
)
