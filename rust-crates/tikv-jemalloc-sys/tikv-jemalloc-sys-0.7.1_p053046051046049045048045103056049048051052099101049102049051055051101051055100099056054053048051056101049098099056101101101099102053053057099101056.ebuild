# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tikv-jemalloc-sys"
CRATE_VERSION="0.7.1+5.3.1-0-g81034ce1f1373e37dc865038e1bc8eeecf559ce8"
CRATE_CHECKSUM="1a2825c78386b4ae0314074867860ba9577875de945f05992c38815cbec327f0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust FFI bindings to jemalloc"
HOMEPAGE="https://github.com/tikv/jemallocator"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
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
