# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno_cache_dir"
CRATE_VERSION="0.25.0"
CRATE_CHECKSUM="19ab8c76d18a8a7511825bfb93e8b35e79b3dd8404a48c570c536db2a3c88855"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cache directory logic used in Deno"
HOMEPAGE="https://github.com/denoland/deno_cache"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"file_fetcher"
	"sync"
	"wasm"
)
