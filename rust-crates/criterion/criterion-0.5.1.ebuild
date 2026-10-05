# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="criterion"
CRATE_VERSION="0.5.1"
CRATE_CHECKSUM="f2b12d017a929603d80db1831cd3a24082f8137ce19c69e6447f54f5fc8d692f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Statistics-driven micro-benchmarking library"
HOMEPAGE="https://bheisler.github.io/criterion.rs/book/index.html"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"async"
	"async_futures"
	"async_smol"
	"async_std"
	"async_tokio"
	"cargo_bench_support"
	"csv_output"
	"default"
	"html_reports"
	"real_blackbox"
	"stable"
)
