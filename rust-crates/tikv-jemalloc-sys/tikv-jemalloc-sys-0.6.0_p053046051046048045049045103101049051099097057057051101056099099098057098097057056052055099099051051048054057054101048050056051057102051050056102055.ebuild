# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tikv-jemalloc-sys"
CRATE_VERSION="0.6.0+5.3.0-1-ge13ca993e8ccb9ba9847cc330696e02839f328f7"
CRATE_CHECKSUM="cd3c60906412afa9c2b5b5a48ca6a5abe5736aec9eb48ad05037a677e52e4e2d"
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
	"profiling"
	"stats"
	"unprefixed_malloc_on_supported_platforms"
)
