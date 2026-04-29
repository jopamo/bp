# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="codspeed-criterion-compat-walltime"
CRATE_VERSION="2.10.1"
CRATE_CHECKSUM="7b0a2f7365e347f4f22a67e9ea689bf7bc89900a354e22e26cf8a531a42c8fbb"
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
