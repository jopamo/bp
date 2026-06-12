# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tikv-jemallocator"
CRATE_VERSION="0.7.0"
CRATE_CHECKSUM="249f09e49ab1609436f34c776e84231bead18d6a955f119f939bdc1d847561bd"
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
	"profiling_libunwind"
	"stats"
	"unprefixed_malloc_on_supported_platforms"
)
