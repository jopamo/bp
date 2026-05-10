# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tikv-jemallocator"
CRATE_VERSION="0.6.0"
CRATE_CHECKSUM="4cec5ff18518d81584f477e9bfdf957f5bb0979b0bac3af4ca30b5b3ae2d2865"
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
	"disable_initial_exec_tls"
	"profiling"
	"stats"
	"unprefixed_malloc_on_supported_platforms"
)
