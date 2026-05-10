# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="codspeed-criterion-compat-walltime"
CRATE_VERSION="3.0.5"
CRATE_CHECKSUM="c989289ce6b1cbde72ed560496cb8fbf5aa14d5ef5666f168e7f87751038352e"
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
