# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tikv-jemalloc-sys"
CRATE_VERSION="0.6.1+5.3.0-1-ge13ca993e8ccb9ba9847cc330696e02839f328f7"
CRATE_CHECKSUM="cd8aa5b2ab86a2cefa406d889139c162cbb230092f7d1d7cbc1716405d852a3b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust FFI bindings to jemalloc"
HOMEPAGE="https://github.com/tikv/jemallocator"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
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
	"stats"
	"unprefixed_malloc_on_supported_platforms"
)
